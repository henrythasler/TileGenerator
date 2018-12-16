#! /bin/bash

# docker run --rm -ti \
# --name postgis \
# -p 5432:5432 \
# --user "$(id -u):$(id -g)" \
# -v /etc/passwd:/etc/passwd:ro \
# -v /media/mapdata/pgdata_henry:/media/mapdata/pgdata_henry \
# -v $(pwd)/postgis.conf:/etc/postgresql/postgresql.conf \
# -e PGDATA=/media/mapdata/pgdata_henry \
# img-postgis:0.8 -c 'config_file=/etc/postgresql/postgresql.conf'

docker run -d \
--name postgis \
-p 5432:5432 \
--user "$(id -u):$(id -g)" \
-v /etc/passwd:/etc/passwd:ro \
-v /media/mapdata/pgdata_henry:/media/mapdata/pgdata_henry \
-v $(pwd)/postgis.conf:/etc/postgresql/postgresql.conf \
-e PGDATA=/media/mapdata/pgdata_henry \
img-postgis:0.8 -c 'config_file=/etc/postgresql/postgresql.conf'

while ! pg_isready -h localhost -p 5432 > /dev/null 2> /dev/null; do
    echo "waiting for database"
    sleep 1
  done