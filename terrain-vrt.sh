#! /bin/bash

demfolder=data/dem/eu
demname=eudem_dem
demdatum=EPSG:4258

shadefolder=data/hillshade/eu
combined=eudem

overlayfolder=data/dem/austria
overlayfile=dhm_lamb_10m
overlaydatum=EPSG:31287
overlayoptions="-tr 40 40"

options="-co BIGTIFF=YES -co TILED=YES -co COMPRESS=DEFLATE -co PREDICTOR=3"
hs_options="-co BIGTIFF=YES -co TILED=YES -co COMPRESS=DEFLATE -co PREDICTOR=2"


# rm $shadefolder/$combined-list.txt
# 
# for file in $demfolder/*.tif 
# do
#   base=`basename $file .tif`
#   echo "Reprojecting" $base.tif
#   rm $shadefolder/$base-3785.tif
#   gdalwarp -s_srs $demdatum -t_srs EPSG:3785 -dstnodata none -r bilinear $options $file $shadefolder/$base-3785.tif
# 
#   echo "Generating hill shading from" $base-3785.tif
#   rm $shadefolder/$base-3785-hs.tif
#   gdaldem hillshade -z 3 -alt 45 -combined -alg ZevenbergenThorne -compute_edges $hs_options $shadefolder/$base-3785.tif $shadefolder/$base-3785-hs.tif
# 
#   echo "Generating overviews for" $base-3785-hs.tif
#   gdaladdo -r average $shadefolder/$base-3785-hs.tif 2 4 8 16 32
# 
#   echo $shadefolder/$base-3785-hs.tif >> $shadefolder/$combined-list.txt
#   echo "\n"
# done  
# 
# echo "Reprojecting" $overlayfile.tif
# gdalwarp -s_srs $overlaydatum -t_srs EPSG:3785 -dstnodata none -r bilinear $overlayoptions $options $overlayfolder/$overlayfile.tif $shadefolder/$overlayfile-3785.tif
# 
# echo "Generating hill shading from" $overlayfile-3785.tif
# gdaldem hillshade -z 2 -alt 45 -combined -compute_edges -alg ZevenbergenThorne $shadefolder/$overlayfile-3785.tif $shadefolder/$overlayfile-3785-hs.tif
# 
# echo "Generating overviews for" $overlayfile-3785-hs.tif
# gdaladdo -r average $shadefolder/$overlayfile-3785-hs.tif 2 4 8 16 32
# 
# echo $shadefolder/$overlayfile-3785-hs.tif >> $shadefolder/$combined-list.txt
# 
# echo "Creating VRT"
# gdalbuildvrt -overwrite -resolution highest -srcnodata 0 -input_file_list $shadefolder/$combined-list.txt $shadefolder/$combined-3785.vrt 

rm $shadefolder/$combined-3785-contour-*

# compute contour lines in parallel processes
(
  gdal_contour -a elev -i 50 $shadefolder/$combined-3785.vrt $shadefolder/$combined-3785-contour-low.shp
) &

(
  gdal_contour -a elev -i 20 $shadefolder/$combined-3785.vrt $shadefolder/$combined-3785-contour-med.shp
) &
wait


