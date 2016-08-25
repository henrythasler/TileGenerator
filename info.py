#!/usr/bin/env python

import sys
import argparse


'''
    Google Earth is in a Geographic coordinate system with the wgs84 datum. (EPSG: 4326)

    Google Maps is in a projected coordinate system that is based on the wgs84 datum. (EPSG 3857)

    The data in Open Street Map database is stored in a gcs with units decimal degrees & datum of wgs84. (EPSG: 4326)

    The Open Street Map tiles and the WMS webservice, are in the projected coordinate system that is based on the wgs84 datum. (EPSG 3857)
'''

#sudo pip install pyproj
from pyproj import Proj, transform


if __name__ == "__main__":
  
    parser = argparse.ArgumentParser(description='Coordinate viewer by Henry Thasler')
    apg_input = parser.add_argument_group('Input')
    apg_input.add_argument("-b", "--bbox", nargs=4, type=float, metavar=('left', 'bottom', 'right', 'top'), help="generate tiles inside a bounding box")
    
    apg_output = parser.add_argument_group('Output')    
    apg_output.add_argument('-z', '--zooms', type=int, nargs=2, metavar=('zmin', 'zmax'), help='range of zoom levels to render (default: 6 12)', default=(6, 12))
  
    options = parser.parse_args()
    
    # check for required argument
    if options.bbox == None:
        parser.print_help()
        sys.exit()    
        
    left = options.bbox[0]
    bottom = options.bbox[1]
    right = options.bbox[2]
    top = options.bbox[3]
    
    print ("Zoom: {}-{}".format(options.zooms[0], options.zooms[1]) )

    print ('### wgs84 datum ###')
    print ("Bounding Box: %s" % (options.bbox,) )
    print 
    
    print ('### epsg:3785 ###')
    p2 = Proj(init='epsg:3785')
    bb = [p2(left, bottom)[0], p2(left, bottom)[1], p2(right, top)[0], p2(right, top)[1]]
    print ("Bounding Box: %s" % (bb,) )
    print 
    
    print ('### epsg:3857 ###')
    p2 = Proj(init='epsg:3857')
    bb = [p2(left, bottom)[0], p2(left, bottom)[1], p2(right, top)[0], p2(right, top)[1]]
    print ("Bounding Box: %s" % (bb,) )
    
    
    
    
    