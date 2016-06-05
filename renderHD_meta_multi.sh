#! /bin/bash

#/usr/share/tilemill/node_modules/carto/bin/carto -l tilemill/project.mml > mycyclemap.xml

#echo $1 $2 $3 $4 $5 $6

tempfile=/tmp/dialog_1_$$

LC_ALL=C
printf -v left "%.8f" "$4"
printf -v bottom "%.8f" "$3"
printf -v right "%.8f" "$2"
printf -v top "%.8f" "$1"

#echo $left $bottom $right $top

menulist=""
dbarray=()
n=1
for item in $(psql -U postgres -d postgres --tuples-only -P format=unaligned -c "SELECT datname FROM pg_database")
do
	menulist="$menulist $n $item"
	dbarray=(${dbarray[@]} $item)
	n=$[n+1]
done
 
dialog --title "TileGenerator" --menu "Please choose a spatial database:" 15 55 10 $menulist 2> $tempfile

retv=$?
[ $retv -eq 1 -o $retv -eq 255 ] && exit

database=${dbarray[$(cat $tempfile)-1]} 
cd /media/Linux-Data/henry/Apps/TileGenerator

# prepare xml-file
cp mycyclemap.xml $database.xml
sed -i 's/mering/'$database'/g' $database.xml

'''
time python generateMetaQueue.py \
      --bbox $left $bottom $right $top \
      --zooms $5 $6 \
      --mapfile $database.xml \
      --scale 2.0 \
      --sqlitedb "/media/henry/Tools/map/tiles/MyCycleMapHD/tilesHD.sqlitedb" \
      --threads 4 \
      --debug 0
'''

time python generateMetaQueue.py \
      --bbox $left $bottom $right $top \
      --zooms $5 $6 \
      --mapfile $database.xml \
      --scale 2.0 \
      --tiledir "/media/henry/Tools/map/tiles/MyCycleMapHD" \
      --threads 4 \
      --debug 3

# wait for user input after completion
rm $database.xml
echo -e "\nPress <Enter> to exit."
read enter
