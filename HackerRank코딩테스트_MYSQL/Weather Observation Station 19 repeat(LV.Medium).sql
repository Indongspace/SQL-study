WITH p1 AS (
    SELECT
        MIN(lat_n) AS a,
        MIN(long_w) AS c 
    FROM station
), p2 AS (
SELECT
    MAX(lat_n) AS b,
    MAX(long_w) AS d
FROM station
)
SELECT
    ROUND(SQRT(POWER(a - b, 2) + POWER(c - d, 2)), 4)
FROM p1, p2
