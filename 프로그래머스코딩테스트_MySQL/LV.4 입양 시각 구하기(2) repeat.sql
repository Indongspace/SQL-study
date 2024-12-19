WITH RECURSIVE day_h AS (
    SELECT 0 AS hour
    UNION ALL
    SELECT hour + 1
    FROM day_h
    WHERE hour < 23
), original_h AS (
    SELECT
        animal_id,
        HOUR(datetime) AS hour
    FROM animal_outs
)
SELECT
    d.hour,
    COUNT(o.animal_id) AS count
FROM day_h AS d
LEFT JOIN original_h AS o
ON d.hour = o.hour
GROUP BY
    d.hour
ORDER BY
    d.hour ASC 
