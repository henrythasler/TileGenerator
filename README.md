# TileGenerator

scripts to generate map tiles

## Performance Measurements

### Environment
Item | Version | Settings
--|--|--
OS | Alpine Linux |
postgres | 10.3 | compiled by gcc (Alpine 6.4.0) 6.4.0, 64 bit
postgis | 2.4.3
DB location | SSD
input PBF location | ramdisk
osm2pgsql | 0.94.0 64bit | -C 12000 -G -v --number-processes 4 --slim

### Test Case 1

Default postgres configuration

```
DROP DATABASE
WARNING:  there is no transaction in progress
COMMIT
CREATE DATABASE
CREATE EXTENSION
CREATE EXTENSION
CREATE EXTENSION
ALTER DATABASE
osm2pgsql version 0.94.0 (64 bit id space)

Using built-in tag processing pipeline
Using projection SRS 3857 (Spherical Mercator)
Setting up table: planet_osm_point
Setting up table: planet_osm_line
Setting up table: planet_osm_polygon
Setting up table: planet_osm_roads
Allocating memory for dense node cache
Allocating dense node cache in one big chunk
Allocating memory for sparse node cache
Sharing dense sparse
Node-cache: cache=12000MB, maxblocks=192000*65536, allocation method=11
Mid: pgsql, cache=12000
Setting up table: planet_osm_nodes
Setting up table: planet_osm_ways
Setting up table: planet_osm_rels

Reading in file: /media/ramdisk/germany-south.osm.pbf
Using PBF parser.
Processing: Node(110950k 114.1k/s) Way(15859k 34.25k/s) Relation(236930 1161.42/s)  parse time: 1640s
Node stats: total(110950380), max(5469955348) in 972s
Way stats: total(15859148), max(568578513) in 463s
Relation stats: total(238778), max(8099669) in 204s
Committing transaction for planet_osm_point
Committing transaction for planet_osm_line
Committing transaction for planet_osm_polygon
Committing transaction for planet_osm_roads
Setting up table: planet_osm_nodes
Setting up table: planet_osm_ways
Setting up table: planet_osm_rels
Using built-in tag processing pipeline
Setting up table: planet_osm_nodes
Setting up table: planet_osm_ways
Setting up table: planet_osm_rels
Using built-in tag processing pipeline
Setting up table: planet_osm_nodes
Setting up table: planet_osm_ways
Setting up table: planet_osm_rels
Using built-in tag processing pipeline
Setting up table: planet_osm_nodes
Setting up table: planet_osm_ways
Setting up table: planet_osm_rels
Using built-in tag processing pipeline

Going over pending ways...
	11438514 ways are pending

Using 4 helper-processes
Finished processing 11438514 ways in 313 s

11438514 Pending ways took 313s at a rate of 36544.77/s
Committing transaction for planet_osm_point
Committing transaction for planet_osm_line
Committing transaction for planet_osm_polygon
Committing transaction for planet_osm_roads
Committing transaction for planet_osm_point
Committing transaction for planet_osm_line
Committing transaction for planet_osm_polygon
Committing transaction for planet_osm_roads
Committing transaction for planet_osm_point
Committing transaction for planet_osm_line
Committing transaction for planet_osm_polygon
Committing transaction for planet_osm_roads
Committing transaction for planet_osm_point
Committing transaction for planet_osm_line
Committing transaction for planet_osm_polygon
Committing transaction for planet_osm_roads

Going over pending relations...
	0 relations are pending

Using 4 helper-processes
Finished processing 0 relations in 0 s

Committing transaction for planet_osm_point
WARNING:  there is no transaction in progress
Committing transaction for planet_osm_line
WARNING:  there is no transaction in progress
Committing transaction for planet_osm_polygon
WARNING:  there is no transaction in progress
Committing transaction for planet_osm_roads
WARNING:  there is no transaction in progress
Committing transaction for planet_osm_point
WARNING:  there is no transaction in progress
Committing transaction for planet_osm_line
WARNING:  there is no transaction in progress
Committing transaction for planet_osm_polygon
WARNING:  there is no transaction in progress
Committing transaction for planet_osm_roads
WARNING:  there is no transaction in progress
Committing transaction for planet_osm_point
WARNING:  there is no transaction in progress
Committing transaction for planet_osm_line
WARNING:  there is no transaction in progress
Committing transaction for planet_osm_polygon
WARNING:  there is no transaction in progress
Committing transaction for planet_osm_roads
WARNING:  there is no transaction in progress
Committing transaction for planet_osm_point
WARNING:  there is no transaction in progress
Committing transaction for planet_osm_line
WARNING:  there is no transaction in progress
Committing transaction for planet_osm_polygon
WARNING:  there is no transaction in progress
Committing transaction for planet_osm_roads
WARNING:  there is no transaction in progress
Sorting data and creating indexes for planet_osm_point
Sorting data and creating indexes for planet_osm_polygon
Sorting data and creating indexes for planet_osm_line
Sorting data and creating indexes for planet_osm_roads
Stopping table: planet_osm_ways
Building index on table: planet_osm_ways
Stopping table: planet_osm_rels
Building index on table: planet_osm_rels
Stopping table: planet_osm_nodes
Stopped table: planet_osm_nodes in 0s
Copying planet_osm_roads to cluster by geometry finished
Creating geometry index on planet_osm_roads
Stopped table: planet_osm_rels in 351s
Creating osm_id index on planet_osm_roads
Creating indexes on planet_osm_roads finished
All indexes on planet_osm_roads created in 424s
Completed planet_osm_roads
Copying planet_osm_point to cluster by geometry finished
Creating geometry index on planet_osm_point
Copying planet_osm_line to cluster by geometry finished
Creating geometry index on planet_osm_line
Creating osm_id index on planet_osm_point
Creating indexes on planet_osm_point finished
All indexes on planet_osm_point created in 1151s
Completed planet_osm_point
Copying planet_osm_polygon to cluster by geometry finished
Creating geometry index on planet_osm_polygon
Creating osm_id index on planet_osm_line
Creating indexes on planet_osm_line finished
All indexes on planet_osm_line created in 1921s
Completed planet_osm_line
Creating osm_id index on planet_osm_polygon
Creating indexes on planet_osm_polygon finished
All indexes on planet_osm_polygon created in 3366s
Completed planet_osm_polygon
Stopped table: planet_osm_ways in 4295s
node cache: stored: 110950380(100.00%), storage efficiency: 50.16% (dense blocks: 436, sparse nodes: 108818382), hit rate: 99.68%

Osm2pgsql took 6249s overall
psql:postprocessing/cycleroutes.sql:1: NOTICE:  table "cycleroutes" does not exist, skipping
DROP TABLE
CREATE TABLE
INSERT 0 1
DROP TABLE
psql:postprocessing/subway.sql:1: NOTICE:  table "subway" does not exist, skipping
DROP TABLE
CREATE TABLE
INSERT 0 9
psql:postprocessing/tram.sql:1: NOTICE:  table "tram" does not exist, skipping
DROP TABLE
CREATE TABLE
INSERT 0 43
psql:postprocessing/tram.sql:25: NOTICE:  table "tram_raw" does not exist, skipping
DROP TABLE
CREATE TABLE
INSERT 0 43

real	110m37,433s
user	8m25,350s
sys	2m21,335s
```

### Testcase 2

High-End config
```
shared_buffers = 12GB
work_mem = 512MB
maintenance_work_mem = 4GB

effective_io_concurrency = 500
max_worker_processes = 8
max_parallel_workers_per_gather = 2
max_parallel_workers = 8

checkpoint_timeout = 1h
max_wal_size = 5GB
min_wal_size = 1GB
checkpoint_completion_target = 0.9

random_page_cost = 1.1
min_parallel_table_scan_size = 8MB
min_parallel_index_scan_size = 512kB
effective_cache_size = 16GB

synchronous_commit = off 
full_page_writes = off 

# only for import
fsync = off	
autovacuum = off
```

```
DROP DATABASE
WARNING:  there is no transaction in progress
COMMIT
CREATE DATABASE
CREATE EXTENSION
CREATE EXTENSION
CREATE EXTENSION
ALTER DATABASE
osm2pgsql version 0.94.0 (64 bit id space)

Using built-in tag processing pipeline
Using projection SRS 3857 (Spherical Mercator)
Setting up table: planet_osm_point
Setting up table: planet_osm_line
Setting up table: planet_osm_polygon
Setting up table: planet_osm_roads
Allocating memory for dense node cache
Allocating dense node cache in one big chunk
Allocating memory for sparse node cache
Sharing dense sparse
Node-cache: cache=12000MB, maxblocks=192000*65536, allocation method=11
Mid: pgsql, cache=12000
Setting up table: planet_osm_nodes
Setting up table: planet_osm_ways
Setting up table: planet_osm_rels

Reading in file: /media/ramdisk/germany-south.osm.pbf
Using PBF parser.
Processing: Node(110950k 208.6k/s) Way(15859k 39.26k/s) Relation(237160 1185.80/s)  parse time: 1137s
Node stats: total(110950380), max(5469955348) in 532s
Way stats: total(15859148), max(568578513) in 404s
Relation stats: total(238778), max(8099669) in 200s
Committing transaction for planet_osm_point
Committing transaction for planet_osm_line
Committing transaction for planet_osm_polygon
Committing transaction for planet_osm_roads
Setting up table: planet_osm_nodes
Setting up table: planet_osm_ways
Setting up table: planet_osm_rels
Using built-in tag processing pipeline
Setting up table: planet_osm_nodes
Setting up table: planet_osm_ways
Setting up table: planet_osm_rels
Using built-in tag processing pipeline
Setting up table: planet_osm_nodes
Setting up table: planet_osm_ways
Setting up table: planet_osm_rels
Using built-in tag processing pipeline
Setting up table: planet_osm_nodes
Setting up table: planet_osm_ways
Setting up table: planet_osm_rels
Using built-in tag processing pipeline

Going over pending ways...
	11438514 ways are pending

Using 4 helper-processes
Finished processing 11438514 ways in 311 s

11438514 Pending ways took 311s at a rate of 36779.79/s
Committing transaction for planet_osm_point
Committing transaction for planet_osm_line
Committing transaction for planet_osm_polygon
Committing transaction for planet_osm_roads
Committing transaction for planet_osm_point
Committing transaction for planet_osm_line
Committing transaction for planet_osm_polygon
Committing transaction for planet_osm_roads
Committing transaction for planet_osm_point
Committing transaction for planet_osm_line
Committing transaction for planet_osm_polygon
Committing transaction for planet_osm_roads
Committing transaction for planet_osm_point
Committing transaction for planet_osm_line
Committing transaction for planet_osm_polygon
Committing transaction for planet_osm_roads

Going over pending relations...
	0 relations are pending

Using 4 helper-processes
Finished processing 0 relations in 0 s

Committing transaction for planet_osm_point
WARNING:  there is no transaction in progress
Committing transaction for planet_osm_line
WARNING:  there is no transaction in progress
Committing transaction for planet_osm_polygon
WARNING:  there is no transaction in progress
Committing transaction for planet_osm_roads
WARNING:  there is no transaction in progress
Committing transaction for planet_osm_point
WARNING:  there is no transaction in progress
Committing transaction for planet_osm_line
WARNING:  there is no transaction in progress
Committing transaction for planet_osm_polygon
WARNING:  there is no transaction in progress
Committing transaction for planet_osm_roads
WARNING:  there is no transaction in progress
Committing transaction for planet_osm_point
WARNING:  there is no transaction in progress
Committing transaction for planet_osm_line
WARNING:  there is no transaction in progress
Committing transaction for planet_osm_polygon
WARNING:  there is no transaction in progress
Committing transaction for planet_osm_roads
WARNING:  there is no transaction in progress
Committing transaction for planet_osm_point
WARNING:  there is no transaction in progress
Committing transaction for planet_osm_line
WARNING:  there is no transaction in progress
Committing transaction for planet_osm_polygon
WARNING:  there is no transaction in progress
Committing transaction for planet_osm_roads
WARNING:  there is no transaction in progress
Sorting data and creating indexes for planet_osm_line
Sorting data and creating indexes for planet_osm_point
Sorting data and creating indexes for planet_osm_polygon
Stopping table: planet_osm_nodes
Stopping table: planet_osm_ways
Building index on table: planet_osm_ways
Stopping table: planet_osm_rels
Building index on table: planet_osm_rels
Sorting data and creating indexes for planet_osm_roads
Stopped table: planet_osm_nodes in 0s
Copying planet_osm_roads to cluster by geometry finished
Creating geometry index on planet_osm_roads
Stopped table: planet_osm_rels in 8s
Creating osm_id index on planet_osm_roads
Creating indexes on planet_osm_roads finished
All indexes on planet_osm_roads created in 9s
Completed planet_osm_roads
Copying planet_osm_point to cluster by geometry finished
Creating geometry index on planet_osm_point
Creating osm_id index on planet_osm_point
Creating indexes on planet_osm_point finished
All indexes on planet_osm_point created in 48s
Completed planet_osm_point
Copying planet_osm_line to cluster by geometry finished
Creating geometry index on planet_osm_line
Creating osm_id index on planet_osm_line
Creating indexes on planet_osm_line finished
All indexes on planet_osm_line created in 1238s
Completed planet_osm_line
Stopped table: planet_osm_ways in 1909s
Copying planet_osm_polygon to cluster by geometry finished
Creating geometry index on planet_osm_polygon
Creating osm_id index on planet_osm_polygon
Creating indexes on planet_osm_polygon finished
All indexes on planet_osm_polygon created in 2418s
Completed planet_osm_polygon
node cache: stored: 110950380(100.00%), storage efficiency: 50.16% (dense blocks: 436, sparse nodes: 108818382), hit rate: 99.67%

Osm2pgsql took 3867s overall
psql:postprocessing/cycleroutes.sql:1: NOTICE:  table "cycleroutes" does not exist, skipping
DROP TABLE
CREATE TABLE
INSERT 0 1
DROP TABLE
psql:postprocessing/subway.sql:1: NOTICE:  table "subway" does not exist, skipping
DROP TABLE
CREATE TABLE
INSERT 0 9
psql:postprocessing/tram.sql:1: NOTICE:  table "tram" does not exist, skipping
DROP TABLE
CREATE TABLE
INSERT 0 43
psql:postprocessing/tram.sql:25: NOTICE:  table "tram_raw" does not exist, skipping
DROP TABLE
CREATE TABLE
INSERT 0 43

real	73m59,389s
user	8m37,129s
sys	2m12,013s
```

### Tesetcase 3

based on https://www.geofabrik.de/media/2012-09-08-osm2pgsql-performance.pdf

```
shared_buffers = 8MB
work_mem = 1MB
maintenance_work_mem = 4GB

effective_io_concurrency = 0

max_wal_size = 2500MB
min_wal_size = 1600MB

random_page_cost = 1.1

# only for import
fsync = off	
autovacuum = off
```

```
DROP DATABASE
WARNING:  there is no transaction in progress
COMMIT
CREATE DATABASE
CREATE EXTENSION
CREATE EXTENSION
CREATE EXTENSION
ALTER DATABASE
osm2pgsql version 0.94.0 (64 bit id space)

Using built-in tag processing pipeline
Using projection SRS 3857 (Spherical Mercator)
Setting up table: planet_osm_point
Setting up table: planet_osm_line
Setting up table: planet_osm_polygon
Setting up table: planet_osm_roads
Allocating memory for dense node cache
Allocating dense node cache in one big chunk
Allocating memory for sparse node cache
Sharing dense sparse
Node-cache: cache=12000MB, maxblocks=192000*65536, allocation method=11
Mid: pgsql, cache=12000
Setting up table: planet_osm_nodes
Setting up table: planet_osm_ways
Setting up table: planet_osm_rels

Reading in file: /media/ramdisk/germany-south.osm.pbf
Using PBF parser.
Processing: Node(110950k 333.2k/s) Way(15859k 44.30k/s) Relation(236900 1144.44/s)  parse time: 899s
Node stats: total(110950380), max(5469955348) in 333s
Way stats: total(15859148), max(568578513) in 358s
Relation stats: total(238778), max(8099669) in 207s
Committing transaction for planet_osm_point
Committing transaction for planet_osm_line
Committing transaction for planet_osm_polygon
Committing transaction for planet_osm_roads
Setting up table: planet_osm_nodes
Setting up table: planet_osm_ways
Setting up table: planet_osm_rels
Using built-in tag processing pipeline
Setting up table: planet_osm_nodes
Setting up table: planet_osm_ways
Setting up table: planet_osm_rels
Using built-in tag processing pipeline
Setting up table: planet_osm_nodes
Setting up table: planet_osm_ways
Setting up table: planet_osm_rels
Using built-in tag processing pipeline
Setting up table: planet_osm_nodes
Setting up table: planet_osm_ways
Setting up table: planet_osm_rels
Using built-in tag processing pipeline

Going over pending ways...
	11438514 ways are pending

Using 4 helper-processes
Finished processing 11438514 ways in 329 s

11438514 Pending ways took 329s at a rate of 34767.52/s
Committing transaction for planet_osm_point
Committing transaction for planet_osm_line
Committing transaction for planet_osm_polygon
Committing transaction for planet_osm_roads
Committing transaction for planet_osm_point
Committing transaction for planet_osm_line
Committing transaction for planet_osm_polygon
Committing transaction for planet_osm_roads
Committing transaction for planet_osm_point
Committing transaction for planet_osm_line
Committing transaction for planet_osm_polygon
Committing transaction for planet_osm_roads
Committing transaction for planet_osm_point
Committing transaction for planet_osm_line
Committing transaction for planet_osm_polygon
Committing transaction for planet_osm_roads

Going over pending relations...
	0 relations are pending

Using 4 helper-processes
Finished processing 0 relations in 0 s

Committing transaction for planet_osm_point
WARNING:  there is no transaction in progress
Committing transaction for planet_osm_line
WARNING:  there is no transaction in progress
Committing transaction for planet_osm_polygon
WARNING:  there is no transaction in progress
Committing transaction for planet_osm_roads
WARNING:  there is no transaction in progress
Committing transaction for planet_osm_point
WARNING:  there is no transaction in progress
Committing transaction for planet_osm_line
WARNING:  there is no transaction in progress
Committing transaction for planet_osm_polygon
WARNING:  there is no transaction in progress
Committing transaction for planet_osm_roads
WARNING:  there is no transaction in progress
Committing transaction for planet_osm_point
WARNING:  there is no transaction in progress
Committing transaction for planet_osm_line
WARNING:  there is no transaction in progress
Committing transaction for planet_osm_polygon
WARNING:  there is no transaction in progress
Committing transaction for planet_osm_roads
WARNING:  there is no transaction in progress
Committing transaction for planet_osm_point
WARNING:  there is no transaction in progress
Committing transaction for planet_osm_line
WARNING:  there is no transaction in progress
Committing transaction for planet_osm_polygon
WARNING:  there is no transaction in progress
Committing transaction for planet_osm_roads
WARNING:  there is no transaction in progress
Sorting data and creating indexes for planet_osm_line
Stopping table: planet_osm_nodes
Sorting data and creating indexes for planet_osm_polygon
Sorting data and creating indexes for planet_osm_point
Stopping table: planet_osm_rels
Building index on table: planet_osm_rels
Stopped table: planet_osm_nodes in 0s
Stopping table: planet_osm_ways
Building index on table: planet_osm_ways
Sorting data and creating indexes for planet_osm_roads
Stopped table: planet_osm_rels in 7s
Copying planet_osm_roads to cluster by geometry finished
Creating geometry index on planet_osm_roads
Creating osm_id index on planet_osm_roads
Creating indexes on planet_osm_roads finished
All indexes on planet_osm_roads created in 20s
Completed planet_osm_roads
Copying planet_osm_point to cluster by geometry finished
Creating geometry index on planet_osm_point
Creating osm_id index on planet_osm_point
Creating indexes on planet_osm_point finished
All indexes on planet_osm_point created in 118s
Completed planet_osm_point
Copying planet_osm_line to cluster by geometry finished
Creating geometry index on planet_osm_line
Creating osm_id index on planet_osm_line
Creating indexes on planet_osm_line finished
All indexes on planet_osm_line created in 951s
Completed planet_osm_line
Copying planet_osm_polygon to cluster by geometry finished
Creating geometry index on planet_osm_polygon
Creating osm_id index on planet_osm_polygon
Creating indexes on planet_osm_polygon finished
All indexes on planet_osm_polygon created in 1312s
Completed planet_osm_polygon
Stopped table: planet_osm_ways in 2200s
node cache: stored: 110950380(100.00%), storage efficiency: 50.16% (dense blocks: 436, sparse nodes: 108818382), hit rate: 99.68%

Osm2pgsql took 3429s overall
psql:postprocessing/cycleroutes.sql:1: NOTICE:  table "cycleroutes" does not exist, skipping
DROP TABLE
CREATE TABLE
INSERT 0 1
DROP TABLE
psql:postprocessing/subway.sql:1: NOTICE:  table "subway" does not exist, skipping
DROP TABLE
CREATE TABLE
INSERT 0 9
psql:postprocessing/tram.sql:1: NOTICE:  table "tram" does not exist, skipping
DROP TABLE
CREATE TABLE
INSERT 0 43
psql:postprocessing/tram.sql:25: NOTICE:  table "tram_raw" does not exist, skipping
DROP TABLE
CREATE TABLE
INSERT 0 43

real	66m38,828s
user	8m31,126s
sys	2m23,963s
```

## how to git

1. git clone https://github.com/henrythasler/TileGenerator.git
2. cd TileGenerator
3. git remote add TileGenerator https://github.com/henrythasler/TileGenerator
4. // do something
5. git add .
6. git commit -a
7. git push TileGenerator master

