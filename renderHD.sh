#! /bin/bash

#/usr/share/tilemill/node_modules/carto/bin/carto -l tilemill/project.mml > mycyclemap.xml

#echo $1 $2 $3 $4 $5 $6

cd /media/Linux-Data/henry/Apps/TileGenerator
time python generate_metatiles.py \
      @left $4 \
      @bottom $3 \
      @right $2 \
      @top $1 \
      @zmin $5 \
      @zmax $6 \
      @scale 2.0 \
      @tiledir "/media/henry/Tools/map/tiles/MyCycleMapHD/" \
      @tileddb "tilesHD.sqlitedb"

# wait for user input after completion
echo -e "\nPress <Enter> to exit."
read enter
