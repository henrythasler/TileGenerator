# https://hc.app.box.com/shared/1yidaheouv

#! /bin/bash
demfolder=data/dem/global
demfile=SRTM_1km.tif
shadefolder=data/hillshade
combined=global1km

echo "Re-projecting: "
#gdalwarp -srcnodata -32768 -dstnodata none -s_srs EPSG:4326 -t_srs EPSG:3785 -r bilinear $shadefolder/$combined.tif $shadefolder/$combined-3785.tif
gdalwarp -srcnodata -32768 -dstnodata none -s_srs EPSG:4326 -t_srs EPSG:3785 -r bilinear $demfolder/$demfile $shadefolder/$combined-3785.tif

echo "Generating hill shading: "
gdaldem hillshade -z 3 -alt 45 -combined -compute_edges -co compress=lzw $shadefolder/$combined-3785.tif $shadefolder/$combined-3785-hs.tif

echo "and overviews: "
gdaladdo -r average $shadefolder/$combined-3785-hs.tif 2 4 8 16 32

# clean up temp data
rm $shadefolder/$combined-3785.tif
