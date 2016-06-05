#!/usr/bin/env python

"""
Python script to generate map tiles with mapnik using metatiles and multiprocessing/threading for improved performance
(c) Henry Thasler
based on other scripts from http://svn.openstreetmap.org/applications/rendering/mapnik/
"""

from math import pi,cos,sin,log,exp,atan,floor,ceil,sqrt
from subprocess import call
from datetime import datetime, timedelta

import sys, os

import sqlite3 as sqlite

from Queue import Queue
import multiprocessing
import threading

import argparse

import mapnik

MULTIPROCESSING = False # True=multiprocessing; False=treading

DEG_TO_RAD = pi/180
RAD_TO_DEG = 180/pi

# Map defines
TILE_SIZE = 256

# Size of one metatile edge (square). The unit is tiles. 8 means one metatile contains up to 64 regular tiles. 8x8=64
META_SIZE = 16

# amount of pixels the metatile is increased on each edge
BUF_SIZE = 1024

# Default number of rendering threads to spawn, should be roughly equal to number of CPU cores available
NUM_THREADS = 4


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
        c = 256
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

class MinimalProgressBar:
    def __init__(self, maxValue, width=50):
      self.maxValue = maxValue
      self.width = width
      self.startTime = datetime.now()
      
    def setMax(self, maxValue):
      self.maxValue = maxValue
      
    def update(self, value):
      percentage = float(value)/self.maxValue
      dots = '.' * int(percentage * self.width)
      spaces = ' ' * (self.width - len(dots))
      delta = datetime.now()-self.startTime
      elapsed = float(delta.microseconds + delta.seconds*1000000 + delta.days*24*60*60*1000000)/1000000
      eta = int(elapsed/max(percentage,0.01) - elapsed)
      hms = "{:02}:{:02}:{:02}".format(eta/3600, (eta/60)%60, eta%60)
      sys.stdout.write("\r[{}] {:6.2%} eta {}".format(dots + spaces, percentage, hms))
      sys.stdout.flush()

class FileWriter:
    def __init__(self, tile_dir):
        self.tile_dir = tile_dir
        if not self.tile_dir.endswith('/'):
            self.tile_dir = self.tile_dir + '/'
        if not os.path.isdir(self.tile_dir):
            os.mkdir(self.tile_dir)

    def __str__(self):
        return "FileWriter({0})".format(self.tile_dir)

    def write_poly(self, poly):
        pass

    def tile_uri(self, x, y, z):
        return '{0}{1}/{2}/{3}.png'.format(self.tile_dir, z, x, y)

    def exists(self, x, y, z):
        return os.path.isfile(self.tile_uri(x, y, z))

    def write(self, x, y, z, imagestring):
        uri = self.tile_uri(x, y, z)
        try:
            os.makedirs(os.path.dirname(uri))
        except OSError:
            pass
          
        fh = open(uri, "wb")
        fh.write(imagestring)
        fh.close()  
#        image.save(uri, 'png256')
        
    def commit(self):
        pass
        
    def need_image(self):
        return True

    def multithreading(self):
        return True

    def close(self):
        pass


class SQLiteDBWriter:
    def __init__(self, database):
        self.database = database
        try:
          self.db = sqlite.connect(self.database)
          self.cur = self.db.cursor()    
          self.cur.execute('CREATE TABLE IF NOT EXISTS tiles (x int, y int, z int, s int, image blob, PRIMARY KEY (x,y,z,s))')
          self.cur.execute('CREATE TABLE IF NOT EXISTS info (minzoom TEXT, maxzoom TEXT)')
          self.cur.execute('CREATE TABLE IF NOT EXISTS android_metadata (locale TEXT)')
          self.cur.execute('CREATE INDEX IF NOT EXISTS IND on tiles(x, y, z, s)')
        except sqlite.Error, e:
            print "SQLiteDBWriter Error %s:" % e.args[0]

    def __str__(self):
        return "SQLiteDBWriter({0})".format(self.database)

    def write_poly(self, poly):
        pass

    def tile_uri(self, x, y, z):
        pass

    def exists(self, x, y, z):
        pass

    def write(self, x, y, z, imagestring):
        if self.db:
          try:          
            self.cur.execute("INSERT OR REPLACE INTO tiles(image, x, y, z, s) VALUES (?, ?, ?, ?, ?)", (sqlite.Binary(imagestring),x,y,17-z,0) )
          except sqlite.Error, e:
            print "SQLiteDBWriter Error %s:" % e.args[0]

    def commit(self):
      if self.db:
        self.db.commit()

    def need_image(self):
        return True

    def multithreading(self):
        return False

    def close(self):
        if self.db:
            self.cur.close()
            self.db.close()

class Command:
    write, commit, sum = range(3)

class WriterThread:
    def __init__(self, options, q, lock):
        self.q = q
        self.lock = lock
        self.options = options
        self.tilecounter = {'sum':0, 'count':0}
        
    def loop(self):

        if self.options.tiledir:
            tiledir = self.options.tiledir
            if not tiledir.endswith('/'):
                tiledir = tiledir + '/'
            self.writer = FileWriter(tiledir) 
        elif self.options.sqlitedb:
            self.writer = SQLiteDBWriter(self.options.sqlitedb)
        else:
            self.writer = FileWriter(os.getcwd() + '/tiles')

        consoleWidth = int(os.popen('stty size', 'r').read().split()[1])
        self.progressBar = MinimalProgressBar(0, consoleWidth-25)

        while True:
            #Fetch a tile from the queue and save it
            item = self.q.get()
            if (item == None):
                self.writer.commit()
                self.writer.close()
                self.q.task_done()
                break
            else:
                (cmd, x, y, z, image) = item

            if cmd == Command.write:
              self.writer.write(x, y, z, image)
              self.tilecounter['count']+=1    
              self.progressBar.update(self.tilecounter['count'])
                
            elif cmd == Command.commit:
              self.writer.commit()
              self.progressBar.update(self.tilecounter['count'])
              
            elif cmd == Command.sum:
              self.tilecounter['sum'] = x
              self.progressBar.setMax(self.tilecounter['sum'])
              self.progressBar.update(self.tilecounter['count'])
            self.q.task_done()



class RenderThread:
    def __init__(self, writer, mapfile, q, lock):
        self.writer = writer
        self.q = q
        self.mapfile = mapfile
        self.lock = lock
        
        self.m = mapnik.Map(TILE_SIZE, TILE_SIZE)

        # Load style XML
        mapnik.load_map(self.m, mapfile, True)
        # Obtain <Map> projection
        self.prj = mapnik.Projection(self.m.srs)
        # Projects between tile pixel co-ordinates and LatLong (EPSG:4326)
        self.tileproj = GoogleProjection()
        

    def render_tile(self, z, scale, p0, p1, metawidth, metaheight, debug):
        # Calculate pixel positions of bottom-left & top-right
#        p0 = (x * 256, (y + 1) * 256)
#        p1 = ((x + 1) * 256, y * 256)

        # Convert to LatLong (EPSG:4326)
        l0 = self.tileproj.fromPixelToLL(p0, z);
        l1 = self.tileproj.fromPixelToLL(p1, z);

        # Convert to map projection (e.g. mercator co-ords EPSG:900913)
        c0 = self.prj.forward(mapnik.Coord(l0[0],l0[1]))
        c1 = self.prj.forward(mapnik.Coord(l1[0],l1[1]))

        # Bounding box for the tile
        bbox = mapnik.Box2d(c0.x,c0.y, c1.x,c1.y)

        self.m.resize(metawidth*TILE_SIZE, metaheight*TILE_SIZE)
        self.m.zoom_to_box(bbox)
        self.m.buffer_size = BUF_SIZE
            
        if debug>=2:    
          self.lock.acquire()
          print z, bbox, metawidth, metaheight
          self.lock.release()    

        # Render image with default Agg renderer
        metaimage = mapnik.Image(metawidth*TILE_SIZE, metaheight*TILE_SIZE)
        mapnik.render(self.m, metaimage, scale)
        
        # save metatile for debug purposes only
#        metaimage.save("/media/henry/Tools/map/tiles/MyCycleMapHD/" + "%s"%z + "-" + "%s" % (p0[0]/TILE_SIZE) + "-" + "%s" % (p1[1]/TILE_SIZE)+".png", 'png256')

        for my in range(0, metaheight):
          for mx in range(0, metawidth):
            tile = metaimage.view(mx*TILE_SIZE, my*TILE_SIZE, TILE_SIZE, TILE_SIZE)
            if debug>=3:    
              self.lock.acquire()
              print "Tile: x=",p0[0]/TILE_SIZE+mx, "y=", p1[1]/TILE_SIZE+my, "z=", z
              self.lock.release()    
              
            item = (Command.write, p0[0]/TILE_SIZE+mx, p1[1]/TILE_SIZE+my, z, tile.tostring('png256'))  
            self.writer.put(item)  

        # commit batch if required (SQLite-db)  
        item = (Command.commit, None, None, None, None)  
        self.writer.put(item)  

    def loop(self):
        
        while True:
            #Fetch a tile from the queue and render it
            metatile = self.q.get()
            if (metatile == None):
                self.q.task_done()
                break
            else:
                (z, scale, p0, p1, metawidth, metaheight, debug) = metatile

            self.render_tile(z, scale, p0, p1, metawidth, metaheight, debug)
            self.q.task_done()



def render_tiles(bbox, zooms, mapfile, writer, lock, num_threads=NUM_THREADS, scale=1, debug=0):
  
    # setup queue to be used as a transfer pipeline to the render processes
    renderQueue = multiprocessing.JoinableQueue(32)

    print "Setting up maps. Please wait..."

    # Launch render processes
    renderers = {}
    for i in range(num_threads):
        renderer = RenderThread(writer, mapfile, renderQueue, lock)
        if MULTIPROCESSING:
          render_thread = multiprocessing.Process(target=renderer.loop)
        else:
          render_thread = threading.Thread(target=renderer.loop)
        render_thread.start()
        renderers[i] = render_thread

    # setup projection shortcuts
    gprj = GoogleProjection(zooms[1]+1) 
    LLtoPx = gprj.fromLLtoPixel
    
    # our map window to render
    ll0 = (bbox[0],bbox[3])
    ll1 = (bbox[2],bbox[1])

    # dimensions of map area for each zoom level ((left, top), (right, bottom))
    px = [[LLtoPx(ll0,z), LLtoPx(ll1,z)] for z in xrange(0, zooms[1]+1)]
    
    # setup tile and metadata dictionarys (https://docs.python.org/2/tutorial/datastructures.html#dictionaries)
    tileData = {'sum':0};  # holds information of all tiles
    metaData = {};         # holds information of all metatiles
    
    # iterate over all requested zoom levels
    for z in range(zooms[0], zooms[1]+1):
      # setup nested dictionaries for this zoom level
      tileData[z]={}
      metaData[z]={}
      
      # compute how many tiles need to be rendered at current zoom level
      tileData[z]['cols'] = int(ceil(px[z][1][0]/TILE_SIZE) - floor(px[z][0][0]/TILE_SIZE)) 
      tileData[z]['rows'] = int(ceil(px[z][1][1]/TILE_SIZE) - floor(px[z][0][1]/TILE_SIZE))
      
      # number of tiles for this zoom level
      tileData[z]['sum'] = tileData[z]['cols'] * tileData[z]['rows']
      
      # update number of tiles overall
      tileData['sum'] += tileData[z]['sum']

      # determine optimal metatile size
      if tileData[z]['sum'] <= (META_SIZE*META_SIZE):
        # whole map at this zoom level fits into one metatile (does not need to be a square) 
        metaData[z]['width'] = tileData[z]['cols']
        metaData[z]['height'] = tileData[z]['rows']
      else:
        if tileData[z]['cols'] <= tileData[z]['rows']:
          metaData[z]['width'] = min(META_SIZE, tileData[z]['cols'])
          metaData[z]['height'] = int(floor(META_SIZE*META_SIZE/metaData[z]['width']))
        else:
          metaData[z]['height'] = min(META_SIZE, tileData[z]['rows'])
          metaData[z]['width'] = int(floor(META_SIZE*META_SIZE/metaData[z]['height']))

      # amount of metatiles for this zoom level   
      metaData[z]['sum'] = int(ceil(float(tileData[z]['sum']) / float(metaData[z]['width']*metaData[z]['height'])))
          
      if debug>=2:
        print "px at z=", z, ": ", px[z]
        print "tileData at z=", z, ": ", tileData[z]
        print "metaData at z=", z, ": ", metaData[z]
        print ""

    print "Tiles to render: ", tileData['sum'], "\n"
      
    # transfer tile count to writer thread  
    item = (Command.sum, tileData['sum'], None, None, None)  
    writer.put(item)  

    # loop over tiles in every zoom level and render metatiles
    for z in range(zooms[0], zooms[1]+1):
      
      # tiles are rendered from left to right beginning at the top left corner and ending at the bottom right corner
      for y in range(0, int(ceil(float(tileData[z]['rows'])/metaData[z]['height']))):
        
        # calculate height of current metatile (can be reduced at bottom/right border of map)
        # check if bottom edge of metatile exceeds overall number of tiles in this column
        if ((y+1)*metaData[z]['height']) > tileData[z]['rows']:
          # yes, limit to max possible
          metaheight = min(metaData[z]['height'],max(0, tileData[z]['rows']-y*metaData[z]['height']))
        else: 
          # no, use full metatile height
          metaheight = metaData[z]['height']
          
        for x in range(0, int(ceil(float(tileData[z]['cols'])/metaData[z]['width']))):
          
          # calculate width of current metatile (can be reduced at bottom/right border of map)
          # check if right border of metatile exceeds overall tiles in this row
          if ((x+1)*metaData[z]['width']) > tileData[z]['cols']:
            # yes, limit metatile dimensions to maximum possible
            metawidth = min(metaData[z]['width'], max(0, tileData[z]['cols']-x*metaData[z]['width']))
          else:
            # no, use full width of metatile
            metawidth = metaData[z]['width']
          
          # calculate dimensions of current metatile in pixels
          left   = int(px[z][0][0]/TILE_SIZE)*TILE_SIZE +  x*metaData[z]['width']*TILE_SIZE
          right  = int(px[z][0][0]/TILE_SIZE)*TILE_SIZE + (x*metaData[z]['width']+metawidth)*TILE_SIZE

          top    = int(px[z][0][1]/TILE_SIZE)*TILE_SIZE +  y*metaData[z]['height']*TILE_SIZE
          bottom = int(px[z][0][1]/TILE_SIZE)*TILE_SIZE +  (y*metaData[z]['height']+metaheight)*TILE_SIZE

          # create set of current metatile for the render queue
          metatile = (z, scale, (left, bottom), (right, top), metawidth, metaheight, debug)

          if debug>=3:
            print "x=",x," y=",y," metawidth=",metawidth, "metaheight=",metaheight, " metatile=",metatile
            
          # add metatile to rendering queue  
          renderQueue.put(metatile)

    # Signal render threads to exit by sending empty request to queue
    for i in range(num_threads):
        renderQueue.put(None)
    # wait for pending rendering jobs to complete
    renderQueue.join()
    for i in range(num_threads):
        renderers[i].join()



if __name__ == "__main__":
  
    mapfile = "mycyclemap.xml"

    parser = argparse.ArgumentParser(description='TileGenerator by Henry Thasler')
    apg_input = parser.add_argument_group('Input')
    apg_input.add_argument("-b", "--bbox", nargs=4, type=float, metavar=('left', 'bottom', 'right', 'top'), help="generate tiles inside a bounding box")
    
    apg_output = parser.add_argument_group('Output')    
    apg_output.add_argument('-z', '--zooms', type=int, nargs=2, metavar=('zmin', 'zmax'), help='range of zoom levels to render (default: 6 12)', default=(6, 12))
    apg_output.add_argument("--tiledir", help="tile output directory")
    apg_output.add_argument("--sqlitedb", help="tile database", default="tiles.sqlitedb")
    apg_output.add_argument("--sqlitetype", help="type of sqlite-database", default="osmand")
  
    apg_other = parser.add_argument_group('Settings')
    apg_other.add_argument('--scale', type=float, help="scale_factor=2", default=1.0)
    apg_other.add_argument('--mapfile', help='style file for mapnik (default: {0})'.format(mapfile), default=mapfile)
    apg_other.add_argument('--threads', type=int, metavar='N', help='number of threads (default: 2)', default=2)
    apg_other.add_argument('--debug', type=int, help='print debug information; 0=off, 1=info, 2=debug, 3=details (default: 0)', default=0)

    options = parser.parse_args()
    
    # check for required argument
    if options.bbox == None:
        parser.print_help()
        sys.exit()    
    
    mapfile = options.mapfile
        
    print ("Bounding Box: %s" % (options.bbox,) )
    print ("Zoom: {}-{}".format(options.zooms[0], options.zooms[1]) )
    print ("Scale: {}\n".format(options.scale) )
    
    # setup queue to be used as a transfer pipeline from the render processes to the writer
    writerQueue = multiprocessing.JoinableQueue(META_SIZE*META_SIZE)
    
    # setup a lock for parts that only one process can execute (e.g. access the same file, print to screen)
    if MULTIPROCESSING:
      lock = multiprocessing.Lock()       # multiprocessing
    else:
      lock = threading.Lock()        # threading

    writer = WriterThread(options, writerQueue, lock)
    if MULTIPROCESSING:
      writer_thread = multiprocessing.Process(target=writer.loop) # multiprocessing
    else:  
      writer_thread = threading.Thread(target=writer.loop)        # threading
    writer_thread.start()
    
    render_tiles(options.bbox, options.zooms, mapfile, writerQueue, lock, num_threads=options.threads, scale=options.scale, debug=options.debug)
    
    writerQueue.put(None)
    # wait for pending rendering jobs to complete
    writerQueue.join()
    writer_thread.join()

    
    
    
    
    
    
    