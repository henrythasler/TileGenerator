DROP TABLE IF EXISTS tram;
CREATE TABLE tram
(
  ref text,
  way geometry
);  

INSERT INTO tram (ref, way)
SELECT DISTINCT reference, ST_LineMerge(ST_ApproximateMedialAxis(ST_Union(ST_Transform(ST_Buffer(ST_Transform(way,4326)::geography, 15)::geometry,900913)))) as way FROM planet_osm_line
JOIN (
        WITH numbered AS(
            SELECT row_number() OVER() AS row, entry, ref
            FROM(
                SELECT unnest(members) AS entry, tags[array_position(tags,'ref')+1] as ref
                FROM planet_osm_rels
                WHERE ARRAY['route','tram']<@tags) AS mylist)
        SELECT ltrim(a.entry,'w')::bigint AS osm_id, a.ref as reference
        FROM numbered AS a JOIN numbered AS b
        ON a.row = b.row-1 AND (b.entry = 'route' OR b.entry = '') AND a.entry ~ '^w[0-9]+' 
) x
USING(osm_id)
GROUP BY reference;


DROP TABLE IF EXISTS tram_raw;
CREATE TABLE tram_raw
(
  ref text,
  way geometry
);  

INSERT INTO tram_raw (ref, way)
SELECT DISTINCT reference, ST_Union(ST_Transform(ST_Buffer(ST_Transform(way,4326)::geography, 15)::geometry,900913)) as way FROM planet_osm_line
JOIN (
        WITH numbered AS(
            SELECT row_number() OVER() AS row, entry, ref
            FROM(
                SELECT unnest(members) AS entry, tags[array_position(tags,'ref')+1] as ref
                FROM planet_osm_rels
                WHERE ARRAY['route','tram']<@tags) AS mylist)
        SELECT ltrim(a.entry,'w')::bigint AS osm_id, a.ref as reference
        FROM numbered AS a JOIN numbered AS b
        ON a.row = b.row-1 AND (b.entry = 'route' OR b.entry = '') AND a.entry ~ '^w[0-9]+' 
) x
USING(osm_id)
GROUP BY reference;
