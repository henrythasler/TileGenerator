#! /bin/bash

# set source path and properties of dem data
demfolder=data/dem/eu
demname=eudem_dem
demdatum=EPSG:4258

# set target path and name prefix
shadefolder=data/hillshade/eu
combined=eudem

# options for gdal (float)
options="-co BIGTIFF=YES -co TILED=YES -co COMPRESS=DEFLATE -co PREDICTOR=3"
# options for gdal (8bit-rgba)
hs_options="-co BIGTIFF=YES -co TILED=YES -co COMPRESS=DEFLATE -co PREDICTOR=2"

# delete old file list for vrt generation
rm $shadefolder/$combined-3785.txt
rm $shadefolder/$combined-3785-hs.txt
rm $shadefolder/$combined-contours.txt
 
# loop over all geo-tiffs in source folder 
for file in $demfolder/*.tif 
do
    # extract filename w/o extension
    base=`basename $file .tif`
    echo "processing" $base.tif
    
    # reproject source file if not already done
    if [ ! -f $shadefolder/$base-3785.tif ]
    then
      echo "Reprojecting" $base.tif
#      gdalwarp -s_srs $demdatum -t_srs EPSG:3785 -multi -dstnodata none -r bilinear -overwrite $options $file $shadefolder/$base-3785.tif
    fi
    echo $shadefolder/$base-3785.tif >> $shadefolder/$combined-3785.txt
    echo $shadefolder/$base-3785.tif >> $shadefolder/$combined-contours.txt
    
    if [ ! -f $shadefolder/$base-3785-hs.tif ]
    then
      echo "Generating hill shading from" $base-3785.tif
#      gdaldem hillshade -z 3 -alt 45 -combined -alg ZevenbergenThorne -compute_edges $hs_options $shadefolder/$base-3785.tif $shadefolder/$base-3785-hs.tif
      echo "Generating overviews for" $base-3785-hs.tif
#      gdaladdo -r average $shadefolder/$base-3785-hs.tif 2 4 8 16 32
    fi
    echo $shadefolder/$base-3785-hs.tif >> $shadefolder/$combined-3785-hs.txt
    
    echo ""
done  


# set source path and properties of overlay dem data
# adding austria
overlayfolder=data/dem/austria
overlayfile=dhm_lamb_10m
overlaydatum=EPSG:31287
overlayoptions="-tr 35 35"

echo "Reprojecting" $overlayfile.tif
#gdalwarp -s_srs $overlaydatum -t_srs EPSG:3785 -multi -dstnodata -1 -r bilinear -overwrite $overlayoptions $options $overlayfolder/$overlayfile.tif $shadefolder/$overlayfile-3785.tif
echo $shadefolder/$overlayfile-3785.tif >> $shadefolder/$combined-3785.txt

echo "Generating hill shading from" $overlayfile-3785.tif
#gdaldem hillshade -z 2 -alt 45 -combined -compute_edges $shadefolder/$overlayfile-3785.tif $shadefolder/$overlayfile-3785-hs.tif

echo "Generating overviews for" $overlayfile-3785-hs.tif
#gdaladdo -r average $shadefolder/$overlayfile-3785-hs.tif 2 4 8 16 32

echo $shadefolder/$overlayfile-3785-hs.tif >> $shadefolder/$combined-3785-hs.txt


# adding alto adige
overlayfolder=data/dem/italy/DTM_5m_asc
overlayfile=dtm5p0m.asc
overlaydatum=EPSG:32632
overlayoptions="-tr 35 35"

echo "Reprojecting" $overlayfile
#gdalwarp -s_srs $overlaydatum -t_srs EPSG:3785 -multi -dstnodata -1 -r bilinear -overwrite $overlayoptions $options $overlayfolder/$overlayfile $shadefolder/$overlayfile-3785.tif
echo $shadefolder/$overlayfile-3785.tif >> $shadefolder/$combined-3785.txt

echo "Generating hill shading from" $overlayfile-3785.tif
#gdaldem hillshade -z 2 -alt 45 -combined -compute_edges $shadefolder/$overlayfile-3785.tif $shadefolder/$overlayfile-3785-hs.tif

echo "Generating overviews for" $overlayfile-3785-hs.tif
#gdaladdo -r average $shadefolder/$overlayfile-3785-hs.tif 2 4 8 16 32

echo $shadefolder/$overlayfile-3785-hs.tif >> $shadefolder/$combined-3785-hs.txt


# adding Shenyang area
overlayfolder=data/dem/global
overlayfile=shenyang
overlaydatum=EPSG:4326
overlayoptions="-tr 35 35"

files=( "data/dem/global/K51/N41E122" "data/dem/global/K51/N41E123" "data/dem/global/K51/N41E124" "data/dem/global/K51/N42E122" "data/dem/global/K51/N42E123" "data/dem/global/K51/N42E124")
mkdir -p $overlayfolder/tmp
rm $overlayfolder/tmp/*.tif

for file in "${files[@]}"
do
  filename=`basename $file`
  echo "processing " $filename
#  gdalwarp -r bilinear -ts 1201 1201 $file.hgt $overlayfolder/tmp/$filename.tif
done

#gdal_merge.py $hs_options $overlayfolder/tmp/*.tif -o $overlayfolder/$overlayfile.tif

echo "Reprojecting" $overlayfile.tif
#gdalwarp -s_srs $overlaydatum -t_srs EPSG:3785 -dstnodata none -r bilinear -overwrite $overlayoptions $hs_options $overlayfolder/$overlayfile.tif $shadefolder/$overlayfile-3785.tif
#echo $shadefolder/$overlayfile-3785.tif >> $shadefolder/$combined-3785.txt

echo "Generating hill shading from" $overlayfile-3785.tif
#gdaldem hillshade -z 2 -alt 45 -combined -compute_edges $shadefolder/$overlayfile-3785.tif $shadefolder/$overlayfile-3785-hs.tif

echo "Generating overviews for" $overlayfile-3785-hs.tif
#gdaladdo -r average $shadefolder/$overlayfile-3785-hs.tif 2 4 8 16 32

#echo $shadefolder/$overlayfile-3785-hs.tif >> $shadefolder/$combined-3785-hs.txt


# adding Beijing area
overlayfolder=data/dem/global
overlayfile=beijing
overlaydatum=EPSG:4326
overlayoptions="-tr 35 35"

files=( "data/dem/global/J50/N39E115" "data/dem/global/J50/N39E116" "data/dem/global/J50/N39E117" "data/dem/global/K50/N40E115" "data/dem/global/K50/N40E116" "data/dem/global/K50/N40E117" )
mkdir -p $overlayfolder/tmp
rm $overlayfolder/tmp/*.tif

for file in "${files[@]}"
do
  filename=`basename $file`
  echo "processing " $filename
#  gdalwarp -r bilinear -ts 1201 1201 $file.hgt $overlayfolder/tmp/$filename.tif
done

#gdal_merge.py $hs_options $overlayfolder/tmp/*.tif -o $overlayfolder/$overlayfile.tif

echo "Reprojecting" $overlayfile.tif
#gdalwarp -s_srs $overlaydatum -t_srs EPSG:3785 -dstnodata none -r bilinear -overwrite $overlayoptions $hs_options $overlayfolder/$overlayfile.tif $shadefolder/$overlayfile-3785.tif
#echo $shadefolder/$overlayfile-3785.tif >> $shadefolder/$combined-3785.txt

echo "Generating hill shading from" $overlayfile-3785.tif
#gdaldem hillshade -z 2 -alt 45 -combined -compute_edges $shadefolder/$overlayfile-3785.tif $shadefolder/$overlayfile-3785-hs.tif

echo "Generating overviews for" $overlayfile-3785-hs.tif
#gdaladdo -r average $shadefolder/$overlayfile-3785-hs.tif 2 4 8 16 32

#echo $shadefolder/$overlayfile-3785-hs.tif >> $shadefolder/$combined-3785-hs.txt




# continue processing of whole dataset
echo "Creating Hillshading VRT"
#gdalbuildvrt -overwrite -resolution highest -srcnodata 0 -input_file_list $shadefolder/$combined-3785-hs.txt $shadefolder/$combined-3785-hs.vrt 

echo "Creating contours"
#gdalbuildvrt -overwrite -resolution highest -srcnodata 0 -input_file_list $shadefolder/$combined-3785.txt $shadefolder/$combined-3785.vrt 
#rm $shadefolder/$combined-3785-contour-low*
#gdal_contour -a elev -i 50 $shadefolder/$combined-3785.vrt $shadefolder/$combined-3785-contour-low.shp &
#rm $shadefolder/$combined-3785-contour-med*
#gdal_contour -a elev -i 20 $shadefolder/$combined-3785.vrt $shadefolder/$combined-3785-contour-med.shp &
#wait

for file in $shadefolder/*-3785.tif 
do
    base=`basename $file .tif`
    echo "processing" $base.tif
#    nodeid=$(($nodeid+10000000))
    #phyghtmap --max-nodes-per-tile=0 --start-node-id=$nodeid --start-way-id=$wayid -s 10 -j 8 -0 -o $shadefolder/$combined --pbf $shadefolder/$base.tif
#    phyghtmap --max-nodes-per-tile=0 -c 50,20 -s 10 -j 4 -0 -o $shadefolder/$combined --pbf $shadefolder/$base.tif
    echo ""
done  

nodeid=0
wayid=0
#phyghtmap --max-nodes-per-tile=0 --start-node-id=500000000 --start-way-id=50000000 -c 50,20 -s 10 -j 4 -0 -o $shadefolder/$combined --pbf $shadefolder/eudem_dem_5deg_n45e005-3785.tif
nodeid=$(($nodeid+500000000))
wayid=$(($wayid+50000000))
#phyghtmap --max-nodes-per-tile=0 --start-node-id=$nodeid --start-way-id=$wayid -c 50,20 -s 10 -j 4 -0 -o $shadefolder/$combined --pbf $shadefolder/eudem_dem_5deg_n45e010-3785.tif

dbname="contours"
psql -U postgres -c "DROP DATABASE IF EXISTS $dbname;"
psql -U postgres -c "COMMIT;"
psql -U postgres -c "CREATE DATABASE $dbname;"
psql -U postgres -d $dbname -c "CREATE EXTENSION postgis;"
psql -U postgres -d $dbname -c "CREATE EXTENSION postgis_topology;"

cnt=0
for file in $shadefolder/*clip_local-source.osm.pbf 
do
    base=`basename $file .pbf`
    echo "importing" $base.pbf
    if (($cnt == 0)) ; then
      echo "creating"
      osm2pgsql -s -C 10000 --verbose --number-processes 2 --username postgres --database $dbname --create --style $dbname.style $file
    else 
      echo "appending"
      osm2pgsql -s -C 10000 --verbose --number-processes 2 --username postgres --database $dbname --append --style $dbname.style $file
    fi
    echo ""
    cnt=$(($cnt+1))
done  

echo "all done"



