#! /bin/bash
# see http://wiki.openstreetmap.org/wiki/Osm2pgsql

# -c   create new
# -G   Generate multi-geometry features
# -U   dbuser
# -d   dbname
# -C   cache size
# -S   style-file

#src="/media/ramdisk/germany-south.osm.pbf"
#dbname="south"
#param="-C 12000 -G -v --number-processes 2"

#src="/media/ramdisk/germany-north.osm.pbf"
#dbname="north"
#param="-C 12000 -G -v --number-processes 2"

#src="/media/ramdisk/germany-middle.osm.pbf"
#dbname="middle"
#param="-C 12000 -G -v --number-processes 2"

#src="/media/henry/Tools/map/data/austria-east.osm.pbf"
#dbname="austria"
#param="-C 12000 -G -v --number-processes 2"

#src="/media/ramdisk/alps.osm.pbf"
#dbname="alps"
#param="-C 12000 -G -v --number-processes 2"

#src="/media/henry/Tools/map/data/testset_munich.osm.pbf"
#dbname="testset"

src="/media/henry/Tools/map/data/slice.osm.pbf"
dbname="mering"
#dbname="empty"
param="-C 10000 -G -v --number-processes 2"

#src="/media/ramdisk/china-latest.osm.pbf"
#dbname="china"
#param="-C 10000 -G -v --number-processes 2"

#src="/media/henry/Tools/map/data/planet_130422-filter.osm.pbf"
#dbname="world"
#param="-C 10000 -G -v --number-processes 2"

##param="--slim --drop -C 12000 -G -v --number-processes 2"


psql -U postgres -c "DROP DATABASE IF EXISTS $dbname;"
psql -U postgres -c "COMMIT;"
psql -U postgres -c "CREATE DATABASE $dbname;"

psql -U postgres -d $dbname -c "CREATE EXTENSION postgis;"
psql -U postgres -d $dbname -c "CREATE EXTENSION postgis_topology;"
#psql -U postgres -q -d $dbname -f /usr/share/postgresql/9.3/contrib/postgis-2.1/postgis.sql
#psql -U postgres -q -d $dbname -f /usr/share/postgresql/9.3/contrib/postgis-2.1/spatial_ref_sys.sql

osm2pgsql $param -U postgres -d $dbname -c -S styles/osm2pgsql.style $src
psql -U postgres -d $dbname -f postprocessing/cycleroutes.sql


#psql -U postgres -c "create database south;"
#psql -U postgres -d south -f /usr/share/postgresql/9.3/contrib/postgis-2.1/postgis.sql
#psql -U postgres -d south -f /usr/share/postgresql/9.3/contrib/postgis-2.1/spatial_ref_sys.sql
#osm2pgsql -C 10000 -G -U postgres -d south -c -S osm2pgsql.style /media/ramdisk/germany_south.osm.pbf

#psql -U postgres -c "create database world;"
#psql -U postgres -d world -f /usr/share/postgresql/9.3/contrib/postgis-2.1/postgis.sql
#psql -U postgres -d world -f /usr/share/postgresql/9.3/contrib/postgis-2.1/spatial_ref_sys.sql
#osm2pgsql -C 10000 -G -U postgres -d world -c -S osm2pgsql.style /media/henry/Tools/map/data/planet_130422-filter.osm.pbf

#psql -U postgres -c "create database mering;"
#psql -U postgres -d mering -f /usr/share/postgresql/9.3/contrib/postgis-2.1/postgis.sql
#psql -U postgres -d mering -f /usr/share/postgresql/9.3/contrib/postgis-2.1/spatial_ref_sys.sql
#osm2pgsql -C 10000 -G -U postgres -d mering -c -S osm2pgsql.style /media/henry/Tools/map/data/slice.osm.pbf

#psql -U postgres -c "create database empty;"
#psql -U postgres -d empty -f /usr/share/postgresql/9.3/contrib/postgis-2.1/postgis.sql
#psql -U postgres -d empty -f /usr/share/postgresql/9.3/contrib/postgis-2.1/spatial_ref_sys.sql
#osm2pgsql -C 10000 -G -U postgres -d empty -c -S osm2pgsql.style /media/henry/Tools/map/data/slice.osm.pbf

#psql -U postgres -c "create database mallorca;"
#psql -U postgres -d mallorca -f /usr/share/postgresql/9.3/contrib/postgis-2.1/postgis.sql
#psql -U postgres -d mallorca -f /usr/share/postgresql/9.3/contrib/postgis-2.1/spatial_ref_sys.sql
#osm2pgsql -C 10000 -G -U postgres -d mallorca -c -S osm2pgsql.style /media/henry/Tools/map/data/mallorca.osm.pbf


#psql -U postgres -c "create database bayern;"
#psql -U postgres -d bayern -f /usr/share/postgresql/9.3/contrib/postgis-2.1/postgis.sql
#psql -U postgres -d bayern -f /usr/share/postgresql/9.3/contrib/postgis-2.1/spatial_ref_sys.sql
#osm2pgsql --slim -C 10000 -U postgres -d bayern -c -S osm2pgsql.style /media/henry/Tools/map/data/oberbayern-latest.osm.pbf


#osm2pgsql -U postgres -d mering --create --number-processes=4 --cache 8000 --slim --multi-geometry --merc --unlogged --flat-nodes flat-nodes.raw -S osm2pgsql.style /media/henry/Tools/map/data/extract.osm.pbf
#osm2pgsql --slim -G -U postgres -d mering -c -S osm2pgsql.style /media/henry/Tools/map/data/slice.osm.pbf
#osm2pgsql --slim -G -U postgres -d alps -c -S osm2pgsql.style /media/henry/Tools/map/data/extract.osm.pbf
#osm2pgsql --slim -G -U postgres -d south -c -S osm2pgsql.style /media/henry/Tools/map/data/germany_south.osm.pbf

# Append
#osm2pgsql --slim -G -U postgres -d mering -S osm2pgsql.style /media/henry/Tools/map/data/extract.osm.pbf

