DROP TABLE IF EXISTS subway;
CREATE TABLE subway
(
  ref text,
  colour text,
  way geometry
);

INSERT INTO subway (ref, colour, way)
SELECT DISTINCT reference, colour, ST_LineMerge(ST_ApproximateMedialAxis(ST_Union(ST_Transform(ST_Buffer(ST_Transform(way,4326)::geography, 15)::geometry,900913)))) as way FROM planet_osm_line
JOIN (
        WITH numbered AS(
            SELECT row_number() OVER() AS row, entry, ref, colour
            FROM(
                SELECT unnest(members) AS entry, tags[array_position(tags,'ref')+1] as ref, tags[array_position(tags,'colour')+1] as colour
                FROM planet_osm_rels
                WHERE ARRAY['route','subway']<@tags) AS mylist)
        SELECT ltrim(a.entry,'w')::bigint AS osm_id, a.ref as reference, a.colour as colour
        FROM numbered AS a JOIN numbered AS b
        ON a.row = b.row-1 AND (b.entry = 'route' OR b.entry = '') AND a.entry ~ '^w[0-9]+'
) x
USING(osm_id)
GROUP BY reference, colour;
