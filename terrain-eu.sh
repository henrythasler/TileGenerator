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
# LZW -> Deflate: -33% filesize; +23% conversion time
options="-co BIGTIFF=YES -co TILED=YES -co COMPRESS=DEFLATE -co PREDICTOR=3"    

hs_options="-co BIGTIFF=YES -co TILED=YES -co COMPRESS=DEFLATE -co PREDICTOR=2"
#mergeoptions="-tr 40 40"

echo "merging GeoTIFF"
rm $shadefolder/$combined.tif
gdal_merge.py $options -o $shadefolder/$combined.tif $demfolder/*.tif 

echo "Re-projecting: "
rm $shadefolder/$combined-3785.tif
gdalwarp -s_srs $demdatum -t_srs EPSG:3785 -r bilinear -ot Float32 $mergeoptions $options $shadefolder/$combined.tif $shadefolder/$combined-3785.tif

echo "Merging overlay"
#gdalwarp -s_srs $overlaydatum -t_srs EPSG:3785 -dstnodata none -r bilinear $overlayfolder/$overlayfile.tif $shadefolder/$combined-3785.tif

echo "Generating hill shading: "
rm $shadefolder/$combined-3785-hs.tif
gdaldem hillshade -z 3 -alt 45 -combined -compute_edges $hs_options $shadefolder/$combined-3785.tif $shadefolder/$combined-3785-hs.tif

echo "and overviews: "
gdaladdo -r average $shadefolder/$combined-3785-hs.tif 2 4 8 16 32

echo "Creating contours: "


# phyghtmap --max-nodes-per-tile=0 -s 100 -0 --pbf $shadefolder/$combined-3785.tif
# dbname="contours"
# param="-C 10000 -G -v --number-processes 2"
# 
# psql -U postgres -c "DROP DATABASE IF EXISTS $dbname;"
# psql -U postgres -c "COMMIT;"
# psql -U postgres -c "CREATE DATABASE $dbname;"
# psql -U postgres -q -d $dbname -f /usr/share/postgresql/9.3/contrib/postgis-2.1/postgis.sql
# psql -U postgres -q -d $dbname -f /usr/share/postgresql/9.3/contrib/postgis-2.1/spatial_ref_sys.sql
# osm2pgsql $param -U postgres -d $dbname -c -S $dbname.style $dbname.pbf
# psql -U postgres -d $dbname -f postprocessing.sql

rm $shadefolder/$combined-3785-contour-low*
#gdal_contour -a elev -i 50 $shadefolder/$combined-3785.tif $shadefolder/$combined-3785-contour-low.shp
rm $shadefolder/$combined-3785-contour-med*
#gdal_contour -a elev -i 20 $shadefolder/$combined-3785.tif $shadefolder/$combined-3785-contour-med.shp

echo "cleaning up temporary data"
#rm $shadefolder/$combined.tif
#rm $shadefolder/$combined-3785.tif
