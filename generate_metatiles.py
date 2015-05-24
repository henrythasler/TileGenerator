#!/usr/bin/env python
# references: https://github.com/CIV-Che/Mapnik-utils

from math import pi,cos,sin,log,exp,atan
from subprocess import call
import sys, os
from Queue import Queue
import argparse

import threading

import mapnik

DEG_TO_RAD = pi/180
RAD_TO_DEG = 180/pi

# Default number of rendering threads to spawn, should be roughly equal to number of CPU cores available
NUM_THREADS = 4

TILE_SIZE = 256
META_SIZE = 16 
BUF_SIZE = 1024

SQ = 1.3 # Criteria of squared polygon

def minmax (a,b,c):
    a = max(a,b)
    a = min(a,c)
    return a

class GoogleProjection:
    def __init__(self,levels=18):
        self.Bc = []
        self.Cc = []
        self.zc = []
        self.Ac = []
        c = TILE_SIZE
        for d in range(0,levels):
            e = c/2;
            self.Bc.append(c/360.0)
            self.Cc.append(c/(2 * pi))
            self.zc.append((e,e))
            self.Ac.append(c)
            c *= 2
                
    def fromLLtoPixel(self,ll,zoom):
         d = self.zc[zoom]
         e = round(d[0] + ll[0] * self.Bc[zoom])
         f = minmax(sin(DEG_TO_RAD * ll[1]),-0.9999,0.9999)
         g = round(d[1] + 0.5*log((1+f)/(1-f))*-self.Cc[zoom])
         return (e,g)
     
    def fromPixelToLL(self,px,zoom):
         e = self.zc[zoom]
         f = (px[0] - e[0])/self.Bc[zoom]
         g = (px[1] - e[1])/-self.Cc[zoom]
         h = RAD_TO_DEG * ( 2 * atan(exp(g)) - 0.5 * pi)
         return (f,h)



class RenderThread:
    def __init__(self, tile_dir, mapfile, q, printLock, maxZoom, scale_factor):
        self.tile_dir = tile_dir
        self.scale_factor = scale_factor
        self.q = q
        self.m = mapnik.Map(TILE_SIZE, TILE_SIZE)
        self.printLock = printLock
        # Load style XML
        mapnik.load_map(self.m, mapfile, True)
        # Obtain <Map> projection
        self.prj = mapnik.Projection(self.m.srs)
        # Projects between tile pixel co-ordinates and LatLong (EPSG:4326)
        self.tileproj = GoogleProjection(maxZoom+1)


    def render_tile(self, x, y, z, m_size):

        ## Calculate pixel positions of bottom-left & top-right
        p0 = (x*TILE_SIZE, (y+m_size)*TILE_SIZE)
        p1 = ((x+m_size)*TILE_SIZE, y*TILE_SIZE)

        ## Convert to LatLong (EPSG:4326)
        l0 = self.tileproj.fromPixelToLL(p0, z);
        l1 = self.tileproj.fromPixelToLL(p1, z);

        ## Convert to map projection (e.g. mercator co-ords EPSG:900913)
        c0 = self.prj.forward(mapnik.Coord(l0[0],l0[1]))
        c1 = self.prj.forward(mapnik.Coord(l1[0],l1[1]))

        ## Bounding box for the tile
        bbox = mapnik.Box2d(c0.x,c0.y, c1.x,c1.y)
        self.m.resize(m_size*TILE_SIZE, m_size*TILE_SIZE)
        self.m.zoom_to_box(bbox)
        self.m.buffer_size = BUF_SIZE  #Default is 128

        # Render image with default Agg renderer
        im = mapnik.Image(m_size*TILE_SIZE, m_size*TILE_SIZE)
        mapnik.render(self.m, im, self.scale_factor)
        
#        im.save(os.path.join(tile_dir, '%s-%s-%s.%s' % (z, x, y, 'png')), 'png256')
        self.printLock.acquire()
        print '%s %s %s' % (z, x, y)
        self.printLock.release()
        
        for dx in xrange(0, m_size):
            dir_uri = os.path.join(tile_dir, '%s' % z, '%s' % (x+dx))
#            print "writing to", dir_uri
            # Make tile directory
            if not os.path.isdir(dir_uri):
                # Some processes may do this in one time (FS handle this but get exception)
                # handle this exception faster than multiprocess lock mechanism
                os.mkdir(dir_uri)

            for dy in xrange(0, m_size):
                ## Calculate full one current tile uri
                tile_uri = os.path.join(dir_uri, '%s.%s' % ((y+dy), 'png'))
                # View one tile from metatile and save here
                im.view(dx*TILE_SIZE, dy*TILE_SIZE, TILE_SIZE, TILE_SIZE).save(tile_uri, 'png256')
                
        


    def loop(self):
        while True:
            #Fetch a tile from the queue and render it
            r = self.q.get()
            if (r == None):
                self.q.task_done()
                break
            else:
                (name, x, y, z, ms) = r

            self.render_tile(x, y, z, ms)
            self.q.task_done()


def render_tiles(bbox, mapfile, tile_dir, minZoom=1,maxZoom=18, scale_factor=1.0, name="unknown", num_threads=NUM_THREADS, tms_scheme=False):
#    print "render_tiles(",bbox, mapfile, tile_dir, minZoom,maxZoom, name,")"

    # Launch rendering threads
    queue = Queue(32)
    printLock = threading.Lock()
    renderers = {}
    for i in range(num_threads):
        renderer = RenderThread(tile_dir, mapfile, queue, printLock, maxZoom, scale_factor)
        render_thread = threading.Thread(target=renderer.loop)
        render_thread.start()
        #print "Started render thread %s" % render_thread.getName()
        renderers[i] = render_thread

    if not os.path.isdir(tile_dir):
         os.mkdir(tile_dir)

    gprj = GoogleProjection(maxZoom+1) 
    LLtoPx = gprj.fromLLtoPixel

    ll0 = (bbox[0],bbox[3])
    ll1 = (bbox[2],bbox[1])
    
    # Calculate optimal size of metatile
    px = [[LLtoPx(ll0,z), LLtoPx(ll1,z)] for z in xrange(0, maxZoom+1)]
    min_max = 1 if (max(abs(px[z][0][0]-px[z][1][0]),abs(px[z][0][1]-px[z][1][1]))/min(abs(px[z][0][0]-px[z][1][0]), 
                abs(px[z][0][1]-px[z][1][1]))) < SQ else 0

    # Calculate size of metatile for all zoom levels
    if min_max:
        meta_size = [int(min(META_SIZE, max(abs(px[z][0][0]-px[z][1][0]),abs(px[z][0][1]-px[z][1][1]))/TILE_SIZE+1) or 1) for z in xrange(0, maxZoom+1)]
    else:
        meta_size = [int(min(META_SIZE, min(abs(px[z][0][0]-px[z][1][0]),abs(px[z][0][1]-px[z][1][1]))/TILE_SIZE+1) or 1) for z in xrange(0, maxZoom+1)]
    
    for z in range(minZoom,maxZoom + 1):
        px0 = gprj.fromLLtoPixel(ll0,z)
        px1 = gprj.fromLLtoPixel(ll1,z)
        
#        print "rendering ",((int(px1[0]/256.0)+1 - int(px0[0]/256.0)) * (int(px1[1]/256.0)+1-int(px0[1]/256.0))), " Tiles at z=",z

        # check if we have directories in place
        zoom = "%s" % z
        if not os.path.isdir(tile_dir + zoom):
            os.mkdir(tile_dir + zoom)

        for mx in xrange(int(px[z][0][0]/TILE_SIZE), int(px[z][1][0]/TILE_SIZE)+1, meta_size[z]):
            # Validate x co-ordinate
            if (mx < 0) or (mx >= 2**z):
                continue
            for my in xrange(int(px[z][0][1]/TILE_SIZE),int(px[z][1][1]/TILE_SIZE)+1, meta_size[z]):
                # Validate x co-ordinate
                if (my < 0) or (my >= 2**z):
                    continue
                # Submit tile to be rendered into the queue
                t = (name, mx, my, z, meta_size[z])
                queue.put(t)


        ## check if we have directories in place
        #zoom = "%s" % z
        #if not os.path.isdir(tile_dir + zoom):
            #os.mkdir(tile_dir + zoom)
            
        #for x in range(int(px0[0]/256.0),int(px1[0]/256.0)+1):
            ## Validate x co-ordinate
            #if (x < 0) or (x >= 2**z):
                #continue
            ## check if we have directories in place
            #str_x = "%s" % x
            #if not os.path.isdir(tile_dir + zoom + '/' + str_x):
                #os.mkdir(tile_dir + zoom + '/' + str_x)
            #for y in range(int(px0[1]/256.0),int(px1[1]/256.0)+1):
                ## Validate x co-ordinate
                #if (y < 0) or (y >= 2**z):
                    #continue
                ## flip y to match OSGEO TMS spec
                #if tms_scheme:
                    #str_y = "%s" % ((2**z-1) - y)
                #else:
                    #str_y = "%s" % y
                #tile_uri = tile_dir + zoom + '/' + str_x + '/' + str_y + '.png'
                ## Submit tile to be rendered into the queue
                #t = (name, tile_uri, x, y, z)
                #try:
                    #queue.put(t)
                #except KeyboardInterrupt:
                    #raise SystemExit("Ctrl-c detected, exiting...")

    # Signal render threads to exit by sending empty request to queue
    for i in range(num_threads):
        queue.put(None)
    # wait for pending rendering jobs to complete
    queue.join()
    for i in range(num_threads):
        renderers[i].join()



if __name__ == "__main__":
  
    parser = argparse.ArgumentParser(description='TileGenerator by Henry Thasler')
    parser.add_argument("--zmin", type=int, help="min zoom", required=True)
    parser.add_argument("--zmax", type=int, help="max zoom",required=True)
    parser.add_argument("--left", type=float, help="left (MIN_LON)",required=True)
    parser.add_argument("--bottom", type=float, help="bottom (MIN_LAT)",required=True)
    parser.add_argument("--right", type=float, help="right (MAX_LON)",required=True)
    parser.add_argument("--top", type=float, help="top (MAX_LAT)",required=True)
    parser.add_argument("--scale", type=float, help="scale_factor=2", default=1.0)
    parser.add_argument("--mapfile", help="mapnik XML file", default="./mycyclemap.xml")
    parser.add_argument("--tiledir", help="tile output directory", default="./tiles/")
    args = parser.parse_args()
    
    ## show values ##
#    mapfile = "./mycyclemap.xml"
#    tile_dir = "./tiles/"
    mapfile = args.mapfile
    tile_dir = args.tiledir

    minZoom = args.zmin
    maxZoom = args.zmax

    if not tile_dir.endswith('/'):
        tile_dir = tile_dir + '/'

    #-------------------------------------------------------------------------
    #
    # Change the following for different bounding boxes and zoom levels
    #
    # Start with an overview
    # World
    #-------------------------------------------------------------------------
    #
    # Change the following for different bounding boxes and zoom levels
    #
    # Start with an overview

    # World  9m26.368s
#    bbox=(-180.0,-90.0, 180.0,90.0)

    
#    render_tiles(bbox, mapfile, tile_dir, 0, 5, "World")

    # Mering
#    bbox=(10.8884,48.2147,11.0842,48.3516)

    # Augsburg
#    bbox=(10.5523681640625, 48.000949575530228, 11.2335205078125, 48.45288728338134)

    # Augsburg - Ulm, z=8
#    bbox=(9.8492431640625, 47.995435916095225, 11.243133544921875, 48.917987254)

    # Schongau
#    bbox=(10.55511474609375, 47.520910478526133, 11.2445068359375, 47.984406829)

	# Donauwoerth
#    bbox=(10.57159423828125, 48.4765629664158, 11.23077392578125, 48.90625412)

    # Augsburg - Schongau
#    bbox=(10.55511474609375, 47.5264746577327, 11.239013671875, 48.451065619)
#    minZoom = 8
#    maxZoom = 14
    
    
    
    # Grossvenediger
#    bbox=(12.030029296875, 47.094435436165931, 12.6068115234375, 47.465236224383617)

    # Ulm, Augsburg, Muenchen, Starnberger See
#    bbox=(9.832763671875, 47.7226969026681, 12.06298828125, 48.511146022547344)

    
    # Augsburg, Muenchen, Walchenee
#    bbox=(10.5633544921875, 47.5264746577327, 11.93939208984375, 48.44924389032873)
 
   
    # Ulm, Ingolstadt, Innsbruck, Chiemsee z=8
    #bbox=(9.854736328125, 47.047668640460834, 12.6397705078125, 48.9152)
    padding=0.1/(1.5**minZoom)
    bbox=(args.left+padding, args.bottom+padding, args.right-padding, args.top-padding)
    
    print ("Bounding Box: %s" % (bbox,) )
    print ("Zoom: {}-{}".format(minZoom, maxZoom) )
    print ("Scale: {}".format(args.scale) )
    
    render_tiles(bbox, mapfile, tile_dir, minZoom, maxZoom, args.scale, "CycleMap")

	
   
