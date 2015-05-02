#! /bin/bash
# see http://wiki.openstreetmap.org/wiki/Osm2pgsql

# -c   create new
# -G   Generate multi-geometry features
# -U   dbuser
# -d   dbname
# -C   cache size
# -S   style-file


psql -U postgres -c "create database alps;"
psql -U postgres -d alps -f /usr/share/postgresql/9.3/contrib/postgis-2.1/postgis.sql
psql -U postgres -d alps -f /usr/share/postgresql/9.3/contrib/postgis-2.1/spatial_ref_sys.sql

#osm2pgsql --slim -G -U postgres -d mering -c -S osm2pgsql.style /media/henry/Tools/map/data/extract.osm.pbf
osm2pgsql --slim -G -U postgres -d alps -c -S osm2pgsql.style /media/henry/Tools/map/data/extract.osm.pbf
#osm2pgsql --slim -G -U postgres -d osm -c -S osm2pgsql.style /media/henry/Tools/map/data/germany_south.osm.pbf
