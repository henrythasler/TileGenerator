#! /bin/bash
/usr/share/tilemill/node_modules/carto/bin/carto -l /media/Linux-Data/henry/Apps/tilemill/project/MyCycleMap2/project.mml > mycyclemap.xml
python generate_tiles.py
