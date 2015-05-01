#! /bin/bash
# see http://wiki.openstreetmap.org/wiki/Osm2pgsql

# -c   create new
# -G   Generate multi-geometry features
# -U   dbuser
# -d   dbname
# -C   cache size
# -S   style-file
osm2pgsql --slim -U postgres -d mering -c -S osm2pgsql.style /media/henry/Tools/map/data/extract.osm.pbf