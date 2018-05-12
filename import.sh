#! /bin/bash
# see http://wiki.openstreetmap.org/wiki/Osm2pgsql

# -c   create new
# -G   Generate multi-geometry features
# -U   dbuser
# -d   dbname
# -C   cache size
# -S   style-file

src="/media/ramdisk/germany-south.osm.pbf"
dbname="south"
param="-C 12000 -G -v --number-processes 4 --slim"

#src="/media/ramdisk/germany-north.osm.pbf"
#dbname="north"
#param="-C 12000 -G -v --number-processes 4 --slim"

#src="/media/ramdisk/germany-middle.osm.pbf"
#dbname="middle"
#param="-C 12000 -G -v --number-processes 4 --slim"

#src="/media/henry/Tools/map/data/austria-east.osm.pbf"
#dbname="austria"
#param="-C 12000 -G -v --number-processes 2"

#src="/media/ramdisk/alps.osm.pbf"
#dbname="alps"
#param="-C 12000 -G -v --number-processes 4 --slim"

#src="/media/henry/Tools/map/data/testset_munich.osm.pbf"
#dbname="testset"

#src="/media/henry/Tools/map/data/slice.osm.pbf"
#dbname="mering"
#param="-C 10000 -G -v --number-processes 4 --slim"

#src="/media/ramdisk/china-latest.osm.pbf"
#dbname="china"
#param="-C 10000 -G -v --number-processes 4 --slim"

#src="/media/henry/Tools/map/data/europe-latest-admin_4-6.osm.pbf"
#dbname="temp"
#param="-C 10000 -v --number-processes 4 -G"


style="styles/osm2pgsql.style"
#style="styles/borders.style"

#param="--slim --drop -C 12000 -G -v --number-processes 2"


psql -U postgres -h localhost -c "DROP DATABASE IF EXISTS $dbname;"
psql -U postgres -h localhost -c "COMMIT;"
psql -U postgres -h localhost -c "CREATE DATABASE $dbname WITH ENCODING='UTF8' CONNECTION LIMIT=-1;"

psql -U postgres -h localhost -d $dbname -c "CREATE EXTENSION postgis;"
psql -U postgres -h localhost -d $dbname -c "CREATE EXTENSION postgis_topology;"
psql -U postgres -h localhost -d $dbname -c "CREATE EXTENSION postgis_sfcgal;"
psql -U postgres -h localhost -d $dbname -c "ALTER DATABASE $dbname SET postgis.backend = sfcgal;"

osm2pgsql $param -U postgres -H localhost -d $dbname -c -S $style $src
psql -U postgres -h localhost -d $dbname -f postprocessing/cycleroutes.sql
psql -U postgres -h localhost -d $dbname -f postprocessing/drop_roads.sql
psql -U postgres -h localhost -d $dbname -f postprocessing/subway.sql
psql -U postgres -h localhost -d $dbname -f postprocessing/tram.sql



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

