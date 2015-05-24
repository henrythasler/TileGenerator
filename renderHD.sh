#! /bin/bash

#/usr/share/tilemill/node_modules/carto/bin/carto -l tilemill/project.mml > mycyclemap.xml

cd /media/Linux-Data/henry/Apps/TileGenerator
time python generate_metatiles.py --left $4 --bottom $3 --right $2 --top $1 --zmin $5 --zmax $6 --scale 2.0 --tiledir "./tilesHD/"

# wait for user input after completion
echo -e "\nPress <Enter> to exit."
read enter
