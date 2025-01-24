WITH base AS (
  SELECT
    season,
    pm10,
    COUNT(*) OVER(PARTITION BY season) AS cnt,
    ROW_NUMBER() OVER(PARTITION BY season ORDER BY pm10 ASC) AS row_num 
  FROM (
    SELECT
      CASE
        WHEN strftime('%m', measured_at) IN ('03','04','05') THEN 'spring'
        WHEN strftime('%m', measured_at) IN ('06','07','08') THEN 'summer'
        WHEN strftime('%m', measured_at) IN ('09','10','11') THEN 'autumn'
        ELSE 'winter'
      END AS season,
      pm10
    FROM measurements
  )
)
SELECT
  season,
  CASE
    WHEN cnt % 2 != 0 THEN (SELECT pm10 FROM base AS b WHERE b.season = base.season AND (cnt / 2) + 1 = b.row_num)
    ELSE (SELECT AVG(pm10) FROM base AS b WHERE b.season = base.season AND b.row_num IN (cnt / 2, (cnt / 2 + 1)))
  END AS pm10_median,
  ROUND(AVG(pm10), 2) AS pm10_average
FROM base
GROUP BY
  season 
