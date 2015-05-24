#! /bin/bash
demfolder=data/dem
shadefolder=data/hillshade
combined=srtm1

xmin=8
xmax=13
ymin=46
ymax=48


echo "removing old files"
rm $shadefolder/$combined*

echo -n "converting hgt"
for ((x=$xmin;x<=$xmax;x++)) do
  for ((y=$ymin;y<=$ymax;y++)) do
    file=$(printf N%02dE%03d ${y%.*} ${x%.*});
    if [ -f $demfolder/$file.hgt ]; then
      echo $demfolder/$file.hgt
#      gdal_translate $demfolder/$file.hgt $demfolder/$file.tif
#      gdalwarp -r bilinear -ts 3601 3601 -srcnodata -32768 -dstnodata none $demfolder/$file.hgt $demfolder/$file.tif
      echo "filling gaps"
      gdal_fillnodata.py $demfolder/$file.hgt $demfolder/$file-fill.tif 
      gdalwarp -r bilinear -ts 3601 3601 $demfolder/$file-fill.tif $demfolder/$file.tif
    else
    echo -n $demfolder/$file.hgt "not available"
    fi
  done
done

echo "merging GeoTIFF"
gdal_merge.py -co BIGTIFF=YES -co TILED=YES -co COMPRESS=LZW -co PREDICTOR=2 $demfolder/*.tif -o $shadefolder/$combined.tif

echo "Re-projecting: "
#gdalwarp -srcnodata -32768 -dstnodata none -s_srs EPSG:4326 -t_srs EPSG:3785 -r bilinear $shadefolder/$combined.tif $shadefolder/$combined-3785.tif
gdalwarp -s_srs EPSG:4326 -t_srs EPSG:3785 -r bilinear $shadefolder/$combined.tif $shadefolder/$combined-3785.tif

echo "Generating hill shading: "
gdaldem hillshade -z 3 -alt 45 -combined -compute_edges -co compress=lzw $shadefolder/$combined-3785.tif $shadefolder/$combined-3785-hs.tif

echo "and overviews: "
gdaladdo -r average $shadefolder/$combined-3785-hs.tif 2 4 8 16 32

echo "Generating slope files: "
#gdaldem slope $shadefolder/$combined-3785.tif $shadefolder/$combined-3785-slope.tif

echo "Translating to 0-90..."
#gdal_translate -ot Byte -scale 0 90 $shadefolder/$combined-3785-slope.tif $shadefolder/$combined-3785-slope-scale.tif

echo "and overviews."
#gdaladdo -r average $shadefolder/$combined-3785-slope-scale.tif 2 4 8 16 32

echo Translating DEM...
#gdal_translate -ot Byte -scale -10 2000 $shadefolder/$combined-3785.tif $shadefolder/$combined-3785-scale.tif

echo and overviews.
#gdaladdo -r average $shadefolder/$combined-3785-scale.tif 2 4 8 16 32

echo Creating contours
gdal_contour -a elev -i 50 $shadefolder/$combined-3785.tif $shadefolder/$combined-3785-contour.shp
gdal_contour -a elev -i 20 $shadefolder/$combined-3785.tif $shadefolder/$combined-3785-contour-high.shp

echo "removing temporary files"
rm $demfolder/*.tif
rm $demfolder/*.aux.xml
