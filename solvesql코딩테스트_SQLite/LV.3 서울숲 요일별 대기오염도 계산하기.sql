SELECT
  weekday,
  ROUND(AVG(no2) , 4) AS no2,
  ROUND(AVG(o3) , 4) AS o3,
  ROUND(AVG(co) , 4) AS co,
  ROUND(AVG(so2) , 4) AS so2,
  ROUND(AVG(pm10) , 4) AS pm10,
  ROUND(AVG(pm2_5) , 4) AS pm2_5
FROM (
  SELECT
    CASE strftime('%w', measured_at)
      WHEN '0' THEN '일요일'
      WHEN '1' THEN '월요일'
      WHEN '2' THEN '화요일'
      WHEN '3' THEN '수요일'
      WHEN '4' THEN '목요일'
      WHEN '5' THEN '금요일'
      ELSE '토요일'
    END AS weekday,
    no2,
    o3,
    co,
    so2,
    pm10,
    pm2_5,
    CASE strftime('%w', measured_at)
      WHEN '0' THEN 7
      WHEN '1' THEN 1
      WHEN '2' THEN 2
      WHEN '3' THEN 3
      WHEN '4' THEN 4
      WHEN '5' THEN 5
      ELSE 6
    END AS sort
  FROM measurements
)
GROUP BY
  weekday
ORDER BY
  sort ASC 
