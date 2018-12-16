#! /bin/bash

# set target path and name prefix
shadefolder=data/hillshade/eu
combined=eudem

# delete old file list for vrt generation
rm $shadefolder/$combined-3785-hs.txt

# add existing files
echo $shadefolder/eudem_dem_5deg_n45e010-3785-hs.tif >> $shadefolder/$combined-3785-hs.txt

# continue processing of whole dataset
echo "Creating Hillshading VRT"
gdalbuildvrt -overwrite -resolution highest -srcnodata 0 -input_file_list $shadefolder/$combined-3785-hs.txt $shadefolder/$combined-3785-hs-simple.vrt 

echo "all done"



