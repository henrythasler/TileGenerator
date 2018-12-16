#!/usr/bin/env python

import subprocess   # subprocess.call(['./test.sh'])
import time
import numpy as np
import operator
import sys
from datetime import datetime
from random import randint
from pprint import pprint
import csv

DB_NAME = "test"

#PBF_FILE = "/media/ramdisk/slice.osm.pbf"
#PBF_FILE = "/media/ramdisk/oberbayern-latest.osm.pbf"
PBF_FILE = "/media/ramdisk/testset.osm.pbf"


class Benchmark:
    def __init__(self, config):
        self.config = config

    def writeConfig(self):
        with open('postgis.conf', 'w') as f:
            for item in self.config:
                if self.config[item] is None:
                    pass
                elif type(self.config[item]) is tuple:
                    f.write("{}={}{}\n".format(item, self.config[item][0], self.config[item][1]))    
                else:
                    f.write("{}={}\n".format(item, self.config[item]))

    def getFitness(self):
        self.writeConfig()

        # stop&remove current postgis container
        subprocess.run(["docker", "rm", "-f", "postgis"], stdout=subprocess.DEVNULL)

        # start postgis container, wait for container to start up properly
        subprocess.run(["./start-postgis.sh"], stdout=subprocess.DEVNULL)

        # recreate database
        subprocess.run(["psql", "-U", "postgres", "-h", "localhost", "-c", "DROP DATABASE IF EXISTS {};".format(DB_NAME)], stdout=subprocess.DEVNULL)
        subprocess.run(["psql", "-U", "postgres", "-h", "localhost", "-c", "COMMIT;"], stdout=subprocess.DEVNULL)
        subprocess.run(["psql", "-U", "postgres", "-h", "localhost", "-c", "CREATE DATABASE {} WITH ENCODING='UTF8' CONNECTION LIMIT=-1;".format(DB_NAME)], stdout=subprocess.DEVNULL)
        
        subprocess.run(["psql", "-U", "postgres", "-h", "localhost", "-d", DB_NAME, "-c", "CREATE EXTENSION postgis;"], stdout=subprocess.DEVNULL)
        subprocess.run(["psql", "-U", "postgres", "-h", "localhost", "-d", DB_NAME, "-c", "CREATE EXTENSION postgis_topology;"], stdout=subprocess.DEVNULL)
        subprocess.run(["psql", "-U", "postgres", "-h", "localhost", "-d", DB_NAME, "-c", "CREATE EXTENSION postgis_sfcgal;"], stdout=subprocess.DEVNULL)
        subprocess.run(["psql", "-U", "postgres", "-h", "localhost", "-d", DB_NAME, "-c", "ALTER DATABASE {} SET postgis.backend = sfcgal;".format(DB_NAME)], stdout=subprocess.DEVNULL)

        start = time.time()
        #time.sleep(randint(2,10))
        subprocess.run(["osm2pgsql", 
            "-C", "12000", "-G", "-v", "--number-processes", "8", "--slim", 
            "-U", "postgres", "-H", "localhost", "-d", DB_NAME, "-c", 
            "-S", "osm2pgsql.style", 
            PBF_FILE])

        end = time.time()
        return(end - start)


if __name__ == "__main__":

    config = [
        # copied from internet
        {   'autovacuum': 'off',
            'effective_io_concurrency': 0,
            'fsync': 'off',
            'full_page_writes': None,
            'listen_addresses': "'*'",
            'maintenance_work_mem': '4GB',
            'max_parallel_workers': None,
            'max_parallel_workers_per_gather': None,
            'max_worker_processes': None,
            'min_wal_size': (1600, 'MB'),
            'max_wal_size': (3200, 'MB'),
            'random_page_cost': 1.1,
            'shared_buffers': '8MB',
            'synchronous_commit': None,
            'work_mem': '1MB'},

        # genetic algorithm
       {'autovacuum': 'off',
              'effective_io_concurrency': 16,
              'fsync': 'off',
              'full_page_writes': 'off',
              'listen_addresses': "'*'",
              'maintenance_work_mem': '8MB',
              'max_parallel_workers': 1,
              'max_parallel_workers_per_gather': 4,
              'max_wal_size': (32, 'MB'),
              'max_worker_processes': 12,
              'min_wal_size': (16, 'MB'),
              'random_page_cost': 1.2,
              'shared_buffers': '4GB',
              'synchronous_commit': 'off',
              'work_mem': '512MB'},

        # genetic algorithm 2
        {'autovacuum': 'off',
              'effective_io_concurrency': 512,
              'fsync': 'off',
              'full_page_writes': 'on',
              'listen_addresses': "'*'",
              'maintenance_work_mem': '4MB',
              'max_parallel_workers': 12,
              'max_parallel_workers_per_gather': 8,
              'max_wal_size': (64, 'MB'),
              'max_worker_processes': 8,
              'min_wal_size': (32, 'MB'),
              'random_page_cost': 1,
              'shared_buffers': '1GB',
              'synchronous_commit': 'off',
              'work_mem': '512MB'}
    ]

    i = 0
    for item in config:
        item["max_wal_size"] = (item["min_wal_size"][0]*2, item["min_wal_size"][1])
        specimen = Benchmark(item)
        fitness = specimen.getFitness()
        print(i, fitness)
        i = i + 1
        sys.stdout.flush()