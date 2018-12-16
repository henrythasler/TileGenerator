#! /bin/bash

#/usr/share/tilemill/node_modules/carto/bin/carto -l tilemill/project.mml > mycyclemap.xml

#echo $1 $2 $3 $4 $5 $6
USERID=$UID
GROUPID=$(id -g)

tempfile=/tmp/dialog_1_$$

LC_ALL=C
printf -v left "%.8f" "$4"
printf -v bottom "%.8f" "$3"
printf -v right "%.8f" "$2"
printf -v top "%.8f" "$1"

#echo $left $bottom $right $top

if [ ! "$(docker ps -q -f name=postgis)" ]; then
    if [ "$(docker ps -aq -f status=exited -f name=postgis)" ]; then
        echo "removing old postgis container"
        docker rm postgis
    fi
    # run your container
    echo "starting postgis container"
    docker run -d \
    --name postgis \
    -p 5432:5432 \
    --user "$(id -u):$(id -g)" \
    -v /etc/passwd:/etc/passwd:ro \
    -v /media/mapdata/pgdata_henry:/media/mapdata/pgdata_henry \
    -v $(pwd)/pg-config/postgis-import.conf:/etc/postgresql/postgresql.conf \
    -e PGDATA=/media/mapdata/pgdata_henry \
    img-postgis:0.8 -c 'config_file=/etc/postgresql/postgresql.conf'
else echo "postgis container already running"
fi

sleep 3s

menulist=""
dbarray=()
n=1
for item in $(psql -U postgres -h localhost -d postgres --tuples-only -P format=unaligned -c "SELECT datname FROM pg_database order by datname asc")
do
	menulist="$menulist $n $item"
	dbarray=(${dbarray[@]} $item)
	n=$[n+1]
done
 
# $ sudo apt install dialog 
dialog --title "TileGenerator" --menu "Please choose a spatial database:" 15 55 10 $menulist 2> $tempfile

retv=$?
[ $retv -eq 1 -o $retv -eq 255 ] && exit

database=${dbarray[$(cat $tempfile)-1]} 
cd /media/mapdata/henry/TileGenerator

# prepare xml-file
cp map.xml $database.xml
sed -i 's/mering/'$database'/g' $database.xml

#time python render.py \
#      --bbox $left $bottom $right $top \
#      --zooms $5 $6 \
#      --mapfile $database.xml \
#      --scale 2.0 \
#      --sqlitedb "/media/henry/Tools/map/tiles/MyCycleMapHD/tilesHD.sqlitedb" \
#      --threads 4 \
#      --debug 0

# time python render.py \
#       --bbox $left $bottom $right $top \
#       --zooms $5 $6 \
#       --mapfile $database.xml \
#       --scale 1.0 \
#       --tiledir "/media/henry/Tools/map/tiles/MyCycleMapHD2" \
#       --threads 4 \
#       --debug 0


docker run --name mapnik -ti --rm \
    --link postgis:postgis \
    -v /media/mapdata/henry:/media/mapdata/henry \
    -v /media/henry/Tools/map/tiles:/media/henry/Tools/map/tiles \
    img-mapnik:2.0 -c "cd /media/mapdata/henry/TileGenerator; time python3 py3_render.py \
            --bbox $left $bottom $right $top \
            --zooms $5 $6 \
            --mapfile $database.xml \
            --scale 1.0 \
            --tiledir \"/media/henry/Tools/map/tiles/MyCycleMapHD2\" \
            --threads 4 \
            --debug 0"
      
# wait for user input after completion
rm $database.xml
echo -e "\nPress <Enter> to exit."
read enter
