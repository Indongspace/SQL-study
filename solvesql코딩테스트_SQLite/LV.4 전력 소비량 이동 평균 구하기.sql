SELECT
  DATETIME(measured_at, '+10 minutes') AS end_at,
  ROUND(AVG(zone_quads) OVER(ORDER BY measured_at ROWS BETWEEN 5 PRECEDING AND CURRENT ROW), 2) AS zone_quads,
  ROUND(AVG(zone_smir) OVER(ORDER BY measured_at ROWS BETWEEN 5 PRECEDING AND CURRENT ROW), 2) AS zone_smir,
  ROUND(AVG(zone_boussafou) OVER(ORDER BY measured_at ROWS BETWEEN 5 PRECEDING AND CURRENT ROW), 2) AS zone_boussafou
FROM power_consumptions
WHERE
  strftime('%Y-%m-%d %H:%M:00', measured_at) < '2017-02-01 00:00:00'
