SELECT
    base.id,
    base.age,
    base.coins_needed,
    base.power
FROM (
    SELECT
        w.id,
        p.age,
        w.coins_needed,
        w.power
    FROM wands AS w
    INNER JOIN wands_property AS p
    ON w.code = p.code
    WHERE
        p.is_evil = 0
) AS base
INNER JOIN (
    SELECT
        p.age,
        w.power,
        MIN(w.coins_needed) AS min_gal
    FROM wands AS w
    INNER JOIN wands_property AS p
    ON w.code = p.code
    WHERE
        p.is_evil = 0
    GROUP BY
        p.age,
        w.power
) AS min_gal
ON base.age = min_gal.age
AND base.power = min_gal.power
AND base.coins_needed = min_gal.min_gal
ORDER BY
    power DESC,
    age DESC
