DROP TABLE IF EXISTS "admin-2";
CREATE TABLE "admin-2"
(
  way geometry(MultiLineString,3785)
);  

INSERT INTO "admin-2" (way)
select ST_LineMerge(ST_Collect(geom)) as way from "admin-2-raw";
