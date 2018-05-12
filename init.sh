#! /bin/bash
# see http://wiki.openstreetmap.org/wiki/Osm2pgsql

# -c   create new
# -G   Generate multi-geometry features
# -U   dbuser
# -d   dbname
# -C   cache size
# -S   style-file

src="/media/henry/Tools/map/data/dummy.osm.pbf"
dbname="world"
param="-C 10000 -G -v --number-processes 4 --slim"

style="styles/osm2pgsql.style"


psql -U postgres -h localhost -c "DROP DATABASE IF EXISTS $dbname;"
psql -U postgres -h localhost -c "COMMIT;"
psql -U postgres -h localhost -c "CREATE DATABASE $dbname WITH ENCODING='UTF8' CONNECTION LIMIT=-1;"

psql -U postgres -h localhost -d $dbname -c "CREATE EXTENSION postgis;"
psql -U postgres -h localhost -d $dbname -c "CREATE EXTENSION postgis_topology;"
psql -U postgres -h localhost -d $dbname -c "CREATE EXTENSION postgis_sfcgal;"
psql -U postgres -h localhost -d $dbname -c "ALTER DATABASE $dbname SET postgis.backend = sfcgal;"

osm2pgsql $param -U postgres -H localhost -d $dbname -c -S $style $src


shp2pgsql -s 3785 /media/mapdata/henry/TileGenerator/data/shp/admin-6-land-boundaries-DE.shp public.admin6_de | psql -U postgres -h localhost -d $dbname

shp2pgsql -s 3785 /media/mapdata/henry/TileGenerator/data/shp/admin-4-land-boundaries-DE.shp public.admin4 | psql -U postgres -h localhost -d $dbname

shp2pgsql -s 3785 /media/mapdata/henry/TileGenerator/data/shp/admin-2-land-boundaries.shp public.admin2 | psql -U postgres -h localhost -d $dbname

shp2pgsql -s 3785 /media/mapdata/henry/TileGenerator/data/shp/admin-2-land-boundaries-simplified.shp public.admin2_simplified | psql -U postgres -h localhost -d $dbname
