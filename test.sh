#! /bin/bash

database="mering" 

# prepare xml-file
cp map.xml $database.xml
sed -i 's/mering/'$database'/g' $database.xml

time python3 py3_render.py \
      --bbox 11 48 11.001 48.001 \
      --zooms 15 15 \
      --mapfile $database.xml \
      --scale 1.0 \
      --tiledir "/media/mapdata/henry/TileGenerator/test" \
      --threads 4 \
      --debug 0

# wait for user input after completion
rm $database.xml
echo -e "\nPress <Enter> to exit."
read enter
