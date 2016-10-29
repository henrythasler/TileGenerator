#! /bin/bash
# see http://wiki.openstreetmap.org/wiki/Osm2pgsql

# -c   create new
# -G   Generate multi-geometry features
# -U   dbuser
# -d   dbname
# -C   cache size
# -S   style-file

src="/media/henry/Tools/map/data/slice.osm.pbf"
dbname="test"
param="-c --slim -G -v --number-processes 1"

psql -U postgres -c "DROP DATABASE IF EXISTS $dbname;"
psql -U postgres -c "COMMIT;"
psql -U postgres -c "CREATE DATABASE $dbname;"
psql -U postgres -d $dbname -c "CREATE EXTENSION postgis;"
psql -U postgres -d $dbname -c "CREATE EXTENSION postgis_topology;"

osm2pgsql $param -U postgres -d $dbname -c -S styles/osm2pgsql.style $src

src="/media/henry/Tools/map/data/mallorca.osm.pbf"
dbname="test"
param="--append --slim -G -v --number-processes 1"

#psql -U postgres -h postgis -c "CREATE DATABASE $dbname;"
#psql -U postgres -h postgis -d $dbname -c "CREATE EXTENSION postgis;"
#psql -U postgres -h postgis -d $dbname -c "CREATE EXTENSION postgis_topology;"

osm2pgsql $param -U postgres -d $dbname -S styles/osm2pgsql.style $src
