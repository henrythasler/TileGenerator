#!/bin/bash

# cuts an area out of infile and writes to outfile
# Parameters: MAX_LAT MAX_LON MIN_LAT MIN_LON 

# settings
osmconvertpath="/media/mapdata/henry/osmtools"
path="/media/henry/Tools/map/data"
read -p "Enter source file: " -e -i $path/europe-latest.osm.pbf source_file
read -p "Enter target file: " -e -i $path/slice.osm.pbf target_file

# info
echo -e "Area: $4,$3,$2,$1\nSource: $source_file\nTarget: $target_file\n"

# actual function call
#time $osmconvertpath/osmconvert --complex-ways -t=/media/ramdisk/ $source_file -b=$4,$3,$2,$1 -o=$target_file -v=2
time $osmconvertpath/osmconvert -t=/media/ramdisk/ $source_file -b=$4,$3,$2,$1 -o=$target_file -v=2

# wait for user input after completion
echo -e "\nPress <Enter> to exit."
read enter
