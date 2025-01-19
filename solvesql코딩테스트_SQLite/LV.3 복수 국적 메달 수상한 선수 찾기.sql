WITH base AS (
  SELECT
    r.athlete_id,
    g.year,
    g.city,
    t.team,
    a.name
  FROM records AS r 
  INNER JOIN games AS g 
  ON r.game_id = g.id
  INNER JOIN teams AS t 
  ON r.team_id = t.id 
  INNER JOIN athletes AS a 
  ON r.athlete_id = a.id 
  WHERE
    g.year >= 2000 AND r.medal IS NOT NULL 
)
SELECT
  name 
FROM base
GROUP BY
  athlete_id
HAVING
  COUNT(DISTINCT team) >= 2
ORDER BY
  name 
