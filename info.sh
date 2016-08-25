#! /bin/bash

LC_ALL=C
printf -v left "%.8f" "$4"
printf -v bottom "%.8f" "$3"
printf -v right "%.8f" "$2"
printf -v top "%.8f" "$1"

cd /media/mapdata/henry/TileGenerator

python info.py \
      --bbox $left $bottom $right $top \
      --zooms $5 $6 \

# wait for user input after completion
echo -e "\nPress <Enter> to exit."
read enter
