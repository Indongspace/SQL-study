SELECT
  s1.station_id,
  s1.name
FROM station AS s1
INNER JOIN station AS s2
ON s1.station_id != s2.station_id
AND s1.updated_at < s2.updated_at
AND (
  6371 * ACOS(
    COS(RADIANS(s1.lat)) * COS(RADIANS(s2.lat)) * COS(RADIANS(s2.lng) - RADIANS(s1.lng))
    + SIN(RADIANS(s1.lat)) * SIN(RADIANS(s2.lat))
  )
) < 0.3
GROUP BY
  s1.station_id
HAVING
  COUNT(s1.station_id) >= 5
