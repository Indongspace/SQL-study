WITH p1 AS (
    SELECT
        MIN(lat_n) AS a,
        MIN(long_w) AS b
    FROM station
), p2 AS (
    SELECT
        MAX(lat_n) AS c,
        MAX(long_w) AS d
    FROM station
)
SELECT
    ROUND(ABS(p1.a - p2.c) + ABS(p1.b - p2.d), 4)
FROM p1,p2