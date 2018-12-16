#! /bin/bash

LC_ALL=C
printf -v left "%.8f" "$4"
printf -v bottom "%.8f" "$3"
printf -v right "%.8f" "$2"
printf -v top "%.8f" "$1"

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

sleep 3s

docker run --name mapnik -ti --rm \
    --link postgis:postgis \
    -v /media/mapdata/henry:/media/mapdata/henry \
    -v /media/henry/Tools/map/tiles:/media/henry/Tools/map/tiles \
    img-mapnik:2.0 -c "cd /media/mapdata/henry/TileGenerator; python3 info.py \
            --bbox $left $bottom $right $top \
            --zooms $5 $6"

#python info.py \
#      --bbox $left $bottom $right $top \
#      --zooms $5 $6 \

# wait for user input after completion
echo -e "\nPress <Enter> to exit."
read enter
