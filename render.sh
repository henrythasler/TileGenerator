#! /bin/bash
/usr/share/tilemill/node_modules/carto/bin/carto -l tilemill/project.mml > mycyclemap.xml
python generate_tiles.py
