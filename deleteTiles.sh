#! /bin/bash

#/usr/share/tilemill/node_modules/carto/bin/carto -l tilemill/project.mml > mycyclemap.xml

#echo $1 $2 $3 $4 $5 $6

LC_ALL=C
printf -v left "%.8f" "$4"
printf -v bottom "%.8f" "$3"
printf -v right "%.8f" "$2"
printf -v top "%.8f" "$1"

#echo $left $bottom $right $top

#      --tiledir "/media/henry/Tools/map/tiles/MyCycleMapHD/" \


cd /media/Linux-Data/henry/Apps/TileGenerator
time python deleteTiles.py \
      --bbox $left $bottom $right $top \
      --zooms $5 $6 \
      --sqlitedb "/media/henry/Tools/map/tiles/MyCycleMapHD/tilesHD.sqlitedb" \
      --threads 1 \
      --debug 0

# wait for user input after completion
echo -e "\nPress <Enter> to exit."
read enter
