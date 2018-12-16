#! /bin/bash

#/usr/share/tilemill/node_modules/carto/bin/carto -l tilemill/project.mml > mycyclemap.xml

#echo $1 $2 $3 $4 $5 $6

LC_ALL=C
printf -v left "%.8f" "$4"
printf -v bottom "%.8f" "$3"
printf -v right "%.8f" "$2"
printf -v top "%.8f" "$1"

#echo $left $bottom $right $top

#     --sqlitedb "/media/henry/Tools/map/tiles/MyCycleMapHD/tilesHD.sqlitedb" \

# cd /media/mapdata/henry/TileGenerator
# time python deleteTiles.py \
#       --bbox $left $bottom $right $top \
#       --zooms $5 $6 \
#       --tiledir "/media/henry/Tools/map/tiles/MyCycleMapHD/" \
#       --threads 1 \
#       --debug 0

docker run --name mapnik -ti --rm \
    -v /media/mapdata/henry:/media/mapdata/henry \
    -v /media/henry/Tools/map/tiles:/media/henry/Tools/map/tiles \
    img-mapnik:2.0 -c "cd /media/mapdata/henry/TileGenerator; time python3 py3_deleteTiles.py \
            --bbox $left $bottom $right $top \
            --zooms $5 $6 \
            --tiledir \"/media/henry/Tools/map/tiles/MyCycleMapHD2\" \
            --threads 1 \
            --debug 0"

# wait for user input after completion
echo -e "\nPress <Enter> to exit."
read enter
