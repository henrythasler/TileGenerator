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
PBF_FILE = "/media/ramdisk/oberbayern-latest.osm.pbf"


class Chromosome:
    def __init__(self, genes=None):

        self.PostgresSettings = {
            "shared_buffers": ["1MB", "2MB", "4MB", "8MB", "16MB", "32MB", "64MB", "128MB", "256MB", "512MB", "1GB", "2GB", "4GB", "8GB"],
            "work_mem": ["1MB", "2MB", "4MB", "8MB", "16MB", "32MB", "64MB", "128MB", "256MB", "512MB", "1GB", "2GB", "4GB", "8GB"],
            "maintenance_work_mem": ["1MB", "2MB", "4MB", "8MB", "16MB", "32MB", "64MB", "128MB", "256MB", "512MB", "1GB", "2GB", "4GB", "8GB"],

            #"effective_io_concurrency": [0, 1, 2, 4, 8, 16, 32, 64, 128, 265, 512],
            #"max_worker_processes": [1, 2, 4, 8, 12, 16],
            #"max_parallel_workers_per_gather": [1, 2, 4, 8, 12, 16],
            #"max_parallel_workers": [1, 2, 4, 8, 12, 16],

            #"max_wal_size": ["2MB", "4MB", "8MB", "16MB", "32MB", "64MB", "128MB", "256MB", "512MB", "1GB", "2GB", "4GB", "8GB"],
            "min_wal_size": [(2, "MB"), (4, "MB"), (8, "MB"), (16, "MB"), (32, "MB"), (64, "MB"), (128, "MB"), (256, "MB"), (512, "MB"), (1, "GB"), (2, "GB"), (4, "GB")],
            #"random_page_cost": [0.9, 1.0, 1.1, 1.2, 1.3],

            #"synchronous_commit": ["off", "on"],
            #"full_page_writes": ["off", "on"],
            #"fsync": ["off", "on"],
            #"autovacuum": ["off", "on"],
        }
        if genes is not None:
            self.genes = genes
        else:
            self.genes = np.random.randint(265, size=len(self.PostgresSettings)).tolist()

        self.normalizeGenes()

        self.fitness = None
       
    def normalizeGenes(self):
        x = 0
        for item in iter(self.PostgresSettings):
            self.genes[x] = self.genes[x] % len(self.PostgresSettings[item])
            x = x + 1

    def getConfig(self):
        config = {"listen_addresses": "'*'"}
        x = 0
        for item in iter(self.PostgresSettings):
            config[item] = self.PostgresSettings[item][self.genes[x] % len(self.PostgresSettings[item])]
            x = x + 1

        # apply rules
        config["max_wal_size"] = (config["min_wal_size"][0]*2, config["min_wal_size"][1])

        # set fixed parameters
        config["fsync"] = "off"
        config["autovacuum"] = "off"
        config["full_page_writes"] = "on"
        config["synchronous_commit"] = "off"

        config["effective_io_concurrency"] = 512
        config["max_worker_processes"] = 8
        config["max_parallel_workers_per_gather"] = 8
        config["max_parallel_workers"] = 12

        return config

    def getKeys(self):
        return self.PostgresSettings.keys

    def getGenes(self):
        return self.genes

    def writeConfig(self):
        with open('postgis.conf', 'w') as f:
            config = self.getConfig()
            for item in config:
                if type(config[item]) is tuple:
                    f.write("{}={}{}\n".format(item, config[item][0],config[item][1]))    
                else:
                    f.write("{}={}\n".format(item, config[item]))

    def getFitness(self):
        if self.fitness is None:
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
            self.fitness = end - start
        return self.fitness

class Population:
    def __init__(self, populationSize):
        self.populationSize = populationSize
        self.chromosomes = [Chromosome() for i in range(self.populationSize)]
        self.fitnessRanking = None
        

    def determineFitness(self):
        self.fitnessRanking = []
        i = 0
        for item in self.chromosomes:
            config = item.getConfig()
            #pprint(config)
            sys.stdout.flush()
            item.writeConfig()

            #fitness = randint(0,100)
            fitness = item.getFitness()

            print("Chromosome {}: {}".format(i, fitness))
            sys.stdout.flush()

            self.fitnessRanking.append({"fitness": fitness, "genes": item.getGenes(), "config":config})
            i = i + 1
            
        
        # sort list
        self.fitnessRanking = sorted(self.fitnessRanking, key=lambda k: k['fitness'])
        return self.fitnessRanking

    def evolvePopulation(self):
        self.chromosomes = []

        # elite selection
        self.chromosomes.append( Chromosome(self.fitnessRanking[0]["genes"]) )

        for i in range(int(self.populationSize/2-0.5)):
            parent1 = self.fitnessRanking[i*2]["genes"]
            parent2 = self.fitnessRanking[i*2+1]["genes"]

            print("Parents", parent1, parent2)
            # create children
            split = randint(0,len(parent1))
            child1 = parent1[:split] + parent2[split:]
            child2 = parent2[:split] + parent1[split:]

            # mutation
            if randint(0,100) > 80:
                print("mutating children")
                pos = randint(0,len(child1)-1)
                child1[pos] = child1[pos] + randint(-2,2)

                pos = randint(0,len(child2)-1)
                child2[pos] = child2[pos] + randint(-2,2)

            print("Children", child1, child2)
            self.chromosomes.append( Chromosome(child1) )
            self.chromosomes.append( Chromosome(child2) )
        
        # new random
        #self.chromosomes.append( Chromosome() )
        self.populationSize = len(self.chromosomes)
        #print(self.chromosomes)        
     

class Laboratory:
    def __init__(self, options):
        self.options = options
        self.population = Population(self.options["populationSize"])
        self.filename = datetime.now().strftime("%Y-%m-%d_%H-%M-%S")+".csv"

    def run(self, iterations = 4):
        for step in range(iterations):
            print("Step {}".format(step))
            result = self.population.determineFitness()

            # print result of iteration
            pprint([len(result), result])
            if step == 0:
                self.writeCSV(result, step, append=False)
            else:
                self.writeCSV(result, step)
            sys.stdout.flush()

            self.population.evolvePopulation()

    def generateReport(self, file):
        pass

    def writeCSV(self, data, step, append=True):
        mode = 'a'
        if append == False:
            mode = 'w'
        
        with open(self.filename, mode) as csvfile:
            fieldnames = ["step", "fitness"]
            fieldnames.extend(list(data[0]["config"].keys()))
            print(fieldnames)
            writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
            if append == False:
                writer.writeheader()
            for item in data:
                line = item["config"]
                line["fitness"] = item["fitness"]
                line["step"] = step
                writer.writerow(line)

if __name__ == "__main__":

    options = {
        "populationSize": 10,
    }

    lab = Laboratory(options)
    lab.run(iterations = 4)
    lab.generateReport("report.md")
