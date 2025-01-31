WITH his_2018 AS (
  SELECT
    station_id,
    SUM(cnt) AS cnt_18
  FROM (
    -- rent_station_id 기준 대여 횟수 집계
    SELECT rent_station_id AS station_id, COUNT(*) AS cnt
    FROM rental_history
    WHERE strftime('%Y-%m', rent_at) = '2018-10'
    GROUP BY rent_station_id
    UNION ALL
    -- return_station_id 기준 반납 횟수 집계
    SELECT return_station_id AS station_id, COUNT(*) AS cnt
    FROM rental_history
    WHERE strftime('%Y-%m', return_at) = '2018-10'
    GROUP BY return_station_id
  ) AS combined
  GROUP BY station_id
),
his_2019 AS (
  SELECT
    station_id,
    SUM(cnt) AS cnt_19
  FROM (
    -- rent_station_id 기준 대여 횟수 집계
    SELECT rent_station_id AS station_id, COUNT(*) AS cnt
    FROM rental_history
    WHERE strftime('%Y-%m', rent_at) = '2019-10'
    GROUP BY rent_station_id
    UNION ALL
    -- return_station_id 기준 반납 횟수 집계
    SELECT return_station_id AS station_id, COUNT(*) AS cnt
    FROM rental_history
    WHERE strftime('%Y-%m', return_at) = '2019-10'
    GROUP BY return_station_id
  ) AS combined
  GROUP BY station_id
)
SELECT
  s.station_id,
  s.name,
  s.local,
  ROUND(h9.cnt_19 * 100.0 / h8.cnt_18, 2) AS usage_pct
FROM station AS s
JOIN his_2018 AS h8 ON s.station_id = h8.station_id
JOIN his_2019 AS h9 ON s.station_id = h9.station_id
WHERE ROUND(h9.cnt_19 * 100.0 / h8.cnt_18, 2) <= 50;
