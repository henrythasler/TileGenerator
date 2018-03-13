DROP TABLE IF EXISTS cycleroutes;
CREATE TABLE cycleroutes
(
  way geometry(MultiLineString,900913)
);  

INSERT INTO cycleroutes (way)
SELECT ST_SetSRID(ST_LineMerge(ST_Collect(way)), 900913) as way
FROM planet_osm_line 
WHERE route='bicycle'; 
