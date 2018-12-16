#! /bin/bash
# see http://wiki.openstreetmap.org/wiki/Osm2pgsql

# -c   create new
# -G   Generate multi-geometry features
# -U   dbuser
# -d   dbname
# -C   cache size
# -S   style-file

if [ ! "$(docker ps -q -f name=postgis)" ]; then
    if [ "$(docker ps -aq -f status=exited -f name=postgis)" ]; then
        echo "removing old postgis container"
        docker rm postgis
    fi
    # run your container
    echo "starting postgis container"
    docker run -d \
    --name postgis \
    -p 5432:5432 \
    --user "$(id -u):$(id -g)" \
    -v /etc/passwd:/etc/passwd:ro \
    -v /media/mapdata/pgdata_henry:/media/mapdata/pgdata_henry \
    -v $(pwd)/pg-config/postgis-import.conf:/etc/postgresql/postgresql.conf \
    -e PGDATA=/media/mapdata/pgdata_henry \
    img-postgis:0.8 -c 'config_file=/etc/postgresql/postgresql.conf'
else echo "postgis container already running"
fi

while ! pg_isready -h localhost -p 5432 > /dev/null 2> /dev/null; do
    echo "waiting for database"
    sleep 1
  done


#src="/media/ramdisk/germany-south.osm.pbf"
#dbname="south"
#param="-C 12000 -G -v --number-processes 8 --slim"

#src="/media/ramdisk/germany-north.osm.pbf"
#dbname="north"
#param="-C 12000 -G -v --number-processes 8 --slim"

#src="/media/ramdisk/germany-middle.osm.pbf"
#dbname="middle"
#param="-C 12000 -G -v --number-processes 8 --slim"

#src="/media/henry/Tools/map/data/austria-east.osm.pbf"
#dbname="austria"
#param="-C 12000 -G -v --number-processes 2"

#src="/media/ramdisk/alps-west.osm.pbf"
#dbname="alps_west"
#param="-C 12000 -G -v --number-processes 8 --slim"

#src="/media/henry/Tools/map/data/testset_munich.osm.pbf"
#dbname="testset"

#src="/media/henry/Tools/map/data/slice.osm.pbf"
#dbname="mering"
#param="-C 10000 -G -v --number-processes 8 --slim"

src="/media/ramdisk/slice.osm.pbf"
dbname="china"
param="-C 12000 -G -v --number-processes 8 --slim"

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

