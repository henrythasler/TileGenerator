# https://hc.app.box.com/shared/1yidaheouv

#! /bin/bash
demfolder=data/dem/eu
demdatum=EPSG:4258

overlayfolder=data/dem/austria
overlayfile=dhm_lamb_10m
overlaydatum=EPSG:31287

shadefolder=data/hillshade
combined=eudem

#options="-co BIGTIFF=YES -co TILED=YES -co COMPRESS=LZW -co PREDICTOR=2"

# http://www.gdal.org/frmt_gtiff.html
# -33% filesize; +23% conversion time
options="-co BIGTIFF=YES -co TILED=YES -co COMPRESS=DEFLATE -co PREDICTOR=3"    

hs_options="-co BIGTIFF=YES -co TILED=YES -co COMPRESS=DEFLATE -co PREDICTOR=2"
mergeoptions="-tr 20 20"

echo "removing old files"
rm $shadefolder/$combined*

echo "merging GeoTIFF"
gdal_merge.py $options -o $shadefolder/$combined.tif $demfolder/*.tif 

echo "Re-projecting: "
gdalwarp -s_srs $demdatum -t_srs EPSG:3785 -r bilinear $mergeoptions $options $shadefolder/$combined.tif $shadefolder/$combined-3785.tif


echo "Merging overlay"
gdalwarp -s_srs $overlaydatum -t_srs EPSG:3785 -dstnodata none -r bilinear $overlayfolder/$overlayfile.tif $shadefolder/$combined-3785.tif

echo "Generating hill shading: "
gdaldem hillshade -z 3 -alt 45 -combined -compute_edges $hs_options $shadefolder/$combined-3785.tif $shadefolder/$combined-3785-hs.tif

echo "and overviews: "
gdaladdo -r average $shadefolder/$combined-3785-hs.tif 2 4 8 16 32

echo "Creating contours: "
gdal_contour -a elev -i 50 $shadefolder/$combined-3785.tif $shadefolder/$combined-3785-contour-low.shp
gdal_contour -a elev -i 20 $shadefolder/$combined-3785.tif $shadefolder/$combined-3785-contour-med.shp
##gdal_contour -a elev -i 10 $shadefolder/$combined-3785.tif $shadefolder/$combined-3785-contour-high.shp


# clean up temp data
rm $shadefolder/$combined.tif
rm $shadefolder/$combined-3785.tif
