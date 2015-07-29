﻿WITH realestate AS (
SELECT nextval('av_mopublic_export.t_id') as t_id, a.t_id as gs_t_id, a.nbident, a.nummer, a.egris_egrid, a.vollstaendigkeit, b.flaechenmass,
 CASE 
   WHEN d.gueltigereintrag IS NULL THEN d.datum1
   ELSE d.gueltigereintrag
 END AS stand_am, 
 b.gem_bfs, b.geometrie
FROM av_avdpool_ng.liegenschaften_lsnachfuehrung as d, av_avdpool_ng.liegenschaften_grundstueck as a, av_avdpool_ng.liegenschaften_liegenschaft as b
WHERE a.gem_bfs = 2583 
AND b.gem_bfs = 2583 
AND d.gem_bfs = 2583
AND b.liegenschaft_von = a.t_id
AND a.entstehung = d.t_id 
),

FOO AS (
INSERT INTO av_mopublic_export.ownership_realestate (t_id, identnd, anumber, egris_egrid, completeness, area, state_of, fosnr, geometry)
SELECT t_id, nbident, nummer, egris_egrid, vollstaendigkeit, flaechenmass, stand_am::timestamp without time zone, gem_bfs, geometrie
FROM realestate
),

realestate_posnumber AS (
SELECT nextval('av_mopublic_export.t_id') as t_id, a.nbident, a.nummer,         
 CASE
  WHEN b.ori IS NULL THEN 100::double precision
  ELSE b.ori
 END AS ori, 
 CASE 
  WHEN b.hali IS NULL THEN 1
  ELSE b.hali
 END as hali,
 CASE 
  WHEN b.vali IS NULL THEN 2
  ELSE b.vali
 END as vali,
 a.gem_bfs, a.t_id as posnumber_of, b.pos
FROM realestate as a, av_avdpool_ng.liegenschaften_grundstueckpos as b
WHERE a.gem_bfs = 2583 
AND b.gem_bfs = 2583
AND a.gs_t_id = b.grundstueckpos_von
)

INSERT INTO av_mopublic_export.ownership_realestate_posnumber (t_id, identnd, anumber, ori, hali, vali, fosnr, posnumber_of, pos)
SELECT t_id, nbident, nummer, ori, hali, vali, gem_bfs, posnumber_of, pos
FROM realestate_posnumber;



