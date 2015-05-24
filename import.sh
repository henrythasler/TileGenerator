#! /bin/bash
# see http://wiki.openstreetmap.org/wiki/Osm2pgsql

# -c   create new
# -G   Generate multi-geometry features
# -U   dbuser
# -d   dbname
# -C   cache size
# -S   style-file


#psql -U postgres -c "create database south;"
#psql -U postgres -d south -f /usr/share/postgresql/9.3/contrib/postgis-2.1/postgis.sql
#psql -U postgres -d south -f /usr/share/postgresql/9.3/contrib/postgis-2.1/spatial_ref_sys.sql
#osm2pgsql -C 10000 -G -U postgres -d south -c -S osm2pgsql.style /media/ramdisk/germany_south.osm.pbf

#psql -U postgres -c "create database mering;"
#psql -U postgres -d mering -f /usr/share/postgresql/9.3/contrib/postgis-2.1/postgis.sql
#psql -U postgres -d mering -f /usr/share/postgresql/9.3/contrib/postgis-2.1/spatial_ref_sys.sql
#osm2pgsql -C 10000 -G -U postgres -d mering -c -S osm2pgsql.style /media/henry/Tools/map/data/slice.osm.pbf

#psql -U postgres -c "create database empty;"
#psql -U postgres -d empty -f /usr/share/postgresql/9.3/contrib/postgis-2.1/postgis.sql
#psql -U postgres -d empty -f /usr/share/postgresql/9.3/contrib/postgis-2.1/spatial_ref_sys.sql
#osm2pgsql -C 10000 -G -U postgres -d empty -c -S osm2pgsql.style /media/henry/Tools/map/data/slice.osm.pbf

psql -U postgres -c "create database mallorca;"
psql -U postgres -d mallorca -f /usr/share/postgresql/9.3/contrib/postgis-2.1/postgis.sql
psql -U postgres -d mallorca -f /usr/share/postgresql/9.3/contrib/postgis-2.1/spatial_ref_sys.sql
osm2pgsql -C 10000 -G -U postgres -d mallorca -c -S osm2pgsql.style /media/henry/Tools/map/data/mallorca.osm.pbf


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
