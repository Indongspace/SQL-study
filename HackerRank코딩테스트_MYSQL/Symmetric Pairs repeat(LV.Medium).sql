SELECT
    base.x,
    base.y
FROM (
    SELECT
        IF(x <= y, x, y) AS x,
        IF(x <= y, y, x) AS y
    FROM functions
) AS base
GROUP BY
    base.x,
    base.y
HAVING
    COUNT(*) >= 2
ORDER BY
    x ASC
    