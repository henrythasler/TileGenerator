#!/usr/bin/env python
# references: https://github.com/CIV-Che/Mapnik-utils

from math import pi,cos,sin,log,exp,atan,ceil, floor
from subprocess import call
import sys, os, inspect
from Queue import Queue
import argparse

import threading
import mapnik
import sqlite3 as sqlite
import time

cmd_subfolder = os.path.realpath(os.path.abspath(os.path.split(inspect.getfile( inspect.currentframe() ))[0]) + "/docs/progressbar-2.3")
if cmd_subfolder not in sys.path:
  sys.path.insert(0, cmd_subfolder)
  
from progressbar import AnimatedMarker, Bar, BouncingBar, Counter, ETA, \
    FormatLabel, Percentage, ProgressBar, ReverseBar, RotatingMarker, \
    SimpleProgress, Timer, FileTransferSpeed

# 0=off; 1=debug; 2=trace
DEBUG_LEVEL = 0

DEG_TO_RAD = pi/180
RAD_TO_DEG = 180/pi

# Default number of rendering threads to spawn, should be roughly equal to number of CPU cores available
NUM_THREADS = 4

TILE_SIZE = 256
META_SIZE = 16 
BUF_SIZE = 1024

SQ = 1.3 # Criteria of squared polygon

# FIXME: do not use globals
tiles_to_render = 0;
tiles_rendered = 0;
tiles_at_zoom = {};


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
    def __init__(self, tile_dir, tile_db, mapfile, q, printLock, maxZoom, scale_factor, pbar):
        self.tile_dir = tile_dir
        self.tile_db = tile_db
        self.scale_factor = scale_factor
        self.q = q
        self.pbar = pbar
        self.m = mapnik.Map(TILE_SIZE, TILE_SIZE)
        self.printLock = printLock
#        self.db = None
        
        # Load style XML
        mapnik.load_map(self.m, mapfile, True)
        # Obtain <Map> projection
        self.prj = mapnik.Projection(self.m.srs)
        # Projects between tile pixel co-ordinates and LatLong (EPSG:4326)
        self.tileproj = GoogleProjection(maxZoom+1)
        
#        sql=MultiThreadOK(self.tile_dir+self.tile_db)


    def render_tile(self, x, y, z, m_size):
        global tiles_to_render
        global tiles_rendered

        ## time render process
        start = time.time();
        
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
        if DEBUG_LEVEL:
            self.printLock.acquire()
            print "rendering z=", z, "x=",x,"y=",y,"p0=",p0,"p1=",p1,"l0=",l0,"l1=",l1,"bbox=", bbox
            self.printLock.release()

        self.m.resize(m_size*TILE_SIZE, m_size*TILE_SIZE)
        self.m.zoom_to_box(bbox)
        self.m.buffer_size = BUF_SIZE  #Default is 128

        # Render image with default Agg renderer
        im = mapnik.Image(m_size*TILE_SIZE, m_size*TILE_SIZE)
        mapnik.render(self.m, im, self.scale_factor)

        # perform disk and screen I/O in lock section
        self.printLock.acquire()
        
#        im.save(os.path.join(tile_dir, '%s-%s-%s.%s' % (z, x, y, 'png')), 'png256')
        for dx in xrange(x, min(x+m_size, (2**z))):
            for dy in xrange(y, min(y+m_size, (2**z))):
                image = im.view((dx-x)*TILE_SIZE, (dy-y)*TILE_SIZE, TILE_SIZE, TILE_SIZE).tostring('png256')
                if DEBUG_LEVEL >= 2:
                    print "Tile: x=",dx, "y=", dy
                tiles_rendered+=1
                self.cur.execute("INSERT OR REPLACE INTO tiles(image, x, y, z, s) VALUES (?, ?, ?, ?, ?)", (sqlite.Binary(image),dx,dy,17-z,0) )
        self.db.commit()

        ## evaluate timing and render progress
        time_elapsed = time.time()-start;
##        tiles_rendered += m_size*m_size
        if DEBUG_LEVEL:
          print 'z=%s x=%s y=%s metasize=%s chunk=%s rendered=%s (%s%%) in %s seconds' % (z, x, y, m_size, m_size*m_size, tiles_rendered, float(tiles_rendered)/float(tiles_to_render)*100, time_elapsed)
        else:
          self.pbar.update(tiles_rendered)

        self.printLock.release()

    def loop(self):
        try:
            self.printLock.acquire()
            self.db = sqlite.connect(self.tile_dir+self.tile_db)
            self.cur = self.db.cursor()    
#            self.cur.execute('SELECT SQLITE_VERSION()')
            self.cur.execute('CREATE TABLE IF NOT EXISTS tiles (x int, y int, z int, s int, image blob, PRIMARY KEY (x,y,z,s))')
            self.cur.execute('CREATE TABLE IF NOT EXISTS info (minzoom TEXT, maxzoom TEXT)')
            self.cur.execute('CREATE TABLE IF NOT EXISTS android_metadata (locale TEXT)')
            self.cur.execute('CREATE INDEX IF NOT EXISTS IND on tiles(x, y, z, s)')
#            self.cur.execute("INSERT OR REPLACE INTO info(minzoom, maxzoom) VALUES (?, ?)", ('2', '17') )
#            self.cur.execute("INSERT OR REPLACE INTO android_metadata(locale) VALUES (?)", ('en_US') )
 #           data = self.cur.fetchone()
#            self.printLock.acquire()
#            print "SQLite version: %s" % data                
            self.printLock.release()
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
        except sqlite.Error, e:
            self.printLock.acquire()
            print "Error %s:" % e.args[0]
            self.printLock.release()
            self.q.task_done()
        finally:
            if self.db:
                self.db.close()
#            self.q.task_done()    


def render_tiles(bbox, mapfile, tile_dir, tile_db, minZoom=1,maxZoom=18, scale_factor=1.0, name="unknown", num_threads=NUM_THREADS, tms_scheme=False):
#    print "render_tiles(",bbox, mapfile, tile_dir, minZoom,maxZoom, name,")"
    global tiles_to_render;
    global tiles_at_zoom;

    # Launch rendering threads
    queue = Queue(32)
    printLock = threading.Lock()
    renderers = {}
    
    gprj = GoogleProjection(maxZoom+1) 
    LLtoPx = gprj.fromLLtoPixel

    ll0 = (bbox[0],bbox[3])
    ll1 = (bbox[2],bbox[1])
    
    # Calculate optimal size of metatile
    px = [[LLtoPx(ll0,z), LLtoPx(ll1,z)] for z in xrange(0, maxZoom+1)]

#    for z in range(0,maxZoom + 1):
#      px[z] = ((px[z][0][0], px[z][0][1]-1), (px[z][1][0], px[z][1][1]-1))

    if DEBUG_LEVEL:
      print "px=", px
    
    min_max = 1 if (max(abs(px[z][0][0]-px[z][1][0]),abs(px[z][0][1]-px[z][1][1]))/min(abs(px[z][0][0]-px[z][1][0]), 
                abs(px[z][0][1]-px[z][1][1]))) < SQ else 0
    if DEBUG_LEVEL:
      print "min_max=", min_max
    
    
    # Calculate size of metatile for all zoom levels
#    if min_max:
#        meta_size = [int(min(META_SIZE, max(abs(px[z][0][0]-px[z][1][0]),abs(px[z][0][1]-px[z][1][1]))/TILE_SIZE+1) or 1) for z in xrange(0, maxZoom+1)]
#    else:
#        meta_size = [int(min(META_SIZE, min(abs(px[z][0][0]-px[z][1][0]),abs(px[z][0][1]-px[z][1][1]))/TILE_SIZE+1) or 1) for z in xrange(0, maxZoom+1)]

    if min_max:
        meta_size = [int(min(META_SIZE, ceil(float(max(abs(px[z][0][0]-px[z][1][0]),abs(px[z][0][1]-px[z][1][1])))/TILE_SIZE)) or 1) for z in xrange(0, maxZoom+1)]
    else:
        meta_size = [int(min(META_SIZE, ceil(float(min(abs(px[z][0][0]-px[z][1][0]),abs(px[z][0][1]-px[z][1][1])))/TILE_SIZE)) or 1) for z in xrange(0, maxZoom+1)]


    ## calculate amount of tiles to render
    for z in range(minZoom,maxZoom + 1):
        tiles_at_zoom[z] = int(ceil(px[z][1][0]/TILE_SIZE - px[z][0][0]/TILE_SIZE)) * int(ceil(px[z][1][1]/TILE_SIZE - px[z][0][1]/TILE_SIZE))
#        tiles_at_zoom[z] = (int(px[z][1][0]/TILE_SIZE)+1 - int(px[z][0][0]/TILE_SIZE)) * (int(px[z][1][1]/TILE_SIZE)+1 - int(px[z][0][1]/TILE_SIZE))
#        tiles_at_zoom[z] = (int(px[z][1][0]/TILE_SIZE)+0 - int(px[z][0][0]/TILE_SIZE)) * (int(px[z][1][1]/TILE_SIZE)+0 - int(px[z][0][1]/TILE_SIZE))
        tiles_to_render += tiles_at_zoom[z]
        if DEBUG_LEVEL:
            print "Tiles at z=",z, ": ",tiles_at_zoom[z], "pixel=", px[z][0][0], px[z][0][1], px[z][1][0], px[z][1][1], "meta=",meta_size[z]

    print "Tiles:", tiles_to_render

    # start rendering and progress bar so tasks in queue will execute
    widgets = ['Rendering: ', Percentage(), ' ',Bar(marker='.',left='[',right=']'), ' ', ETA()]
    
    
    pbar = ProgressBar(widgets=widgets, maxval=tiles_to_render)

    if not DEBUG_LEVEL:    
        pbar.start()
    
    for i in range(num_threads):
        renderer = RenderThread(tile_dir, tile_db, mapfile, queue, printLock, maxZoom, scale_factor, pbar)
        renderers[i] = threading.Thread(target=renderer.loop)
        renderers[i].start()
    
    for z in range(minZoom,maxZoom + 1):
        px0 = gprj.fromLLtoPixel(ll0,z)
        px1 = gprj.fromLLtoPixel(ll1,z)

        for mx in xrange(int(floor(px[z][0][0]/TILE_SIZE)), int(ceil(px[z][1][0]/TILE_SIZE)), meta_size[z]):
            # Validate x co-ordinate
#            print "mx=",mx
            if (mx < 0) or (mx >= 2**z):
                continue
            for my in xrange(int(floor(px[z][0][1]/TILE_SIZE)),int(ceil(px[z][1][1]/TILE_SIZE)), meta_size[z]):
#                print "my=",my
#            for my in xrange(int(px[z][0][1]/TILE_SIZE),int(px[z][1][1]/TILE_SIZE)+1, meta_size[z]):
                # Validate x co-ordinate
                if (my < 0) or (my >= 2**z):
                    continue
                # Submit tile to be rendered into the queue
                t = (name, mx, my, z, meta_size[z])
                queue.put(t)

    # Signal render threads to exit by sending empty request to queue
    for i in range(num_threads):
        queue.put(None)
    # wait for pending rendering jobs to complete
    queue.join()
    for i in range(num_threads):
        renderers[i].join()
    
    if not DEBUG_LEVEL:
        pbar.finish()


if __name__ == "__main__":
  
    # Argument can be -3.032E-8, so: http://stackoverflow.com/questions/9025204/python-argparse-issue-with-optional-arguments-which-are-negative-numbers
    parser = argparse.ArgumentParser(description='TileGenerator by Henry Thasler', prefix_chars='@')
    parser.add_argument("@zmin", type=int, help="min zoom", required=True)
    parser.add_argument("@zmax", type=int, help="max zoom",required=True)
    parser.add_argument("@left", type=float, help="left (MIN_LON)",required=True)
    parser.add_argument("@bottom", type=float, help="bottom (MIN_LAT)",required=True)
    parser.add_argument("@right", type=float, help="right (MAX_LON)",required=True)
    parser.add_argument("@top", type=float, help="top (MAX_LAT)",required=True)
    parser.add_argument("@scale", type=float, help="scale_factor=2", default=1.0)
    parser.add_argument("@mapfile", help="mapnik XML file", default="./mycyclemap.xml")
    parser.add_argument("@tiledir", help="tile output directory", default="./tiles/")
    parser.add_argument("@tileddb", help="tile database", default="tiles.sqlitedb")
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
    
    
    bbox=(args.left, args.bottom, args.right, args.top)
    print ("Bounding Box: %s" % (bbox,) )
    print ("Zoom: {}-{}".format(minZoom, maxZoom) )
    print ("Scale: {}".format(args.scale) )
    
    render_tiles(bbox, mapfile, tile_dir, args.tileddb, minZoom, maxZoom, args.scale, "CycleMap")

	
   
