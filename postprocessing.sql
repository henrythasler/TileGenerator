DROP TABLE IF EXISTS planet_osm_roads;

DROP TABLE IF EXISTS cycleroutes;
CREATE TABLE cycleroutes
(
  way geometry(MultiLineString,900913)
);  

INSERT INTO cycleroutes (way)
SELECT ST_LineMerge(ST_Collect(way)) as way
FROM planet_osm_line 
WHERE route='bicycle'; 


--DROP TABLE IF EXISTS borders;
--CREATE TABLE borders
--(
--  way geometry(MultiLineString,900913)
--);  

--INSERT INTO borders (way)
--SELECT ST_LineMerge(ST_Collect(way)) as way
--FROM planet_osm_line 
--WHERE boundary = 'administrative' 
--AND admin_level = '2'; 
