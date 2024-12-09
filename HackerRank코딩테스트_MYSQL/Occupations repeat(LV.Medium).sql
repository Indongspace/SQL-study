WITH base AS (
    SELECT
        occupation,
        name,
        ROW_NUMBER() OVER(PARTITION BY occupation ORDER BY name) AS row_num
    FROM occupations
)
SELECT
    MAX(CASE WHEN occupation = 'Doctor' THEN name END) AS Doctor,
    MAX(CASE WHEN occupation = 'Professor' THEN name END) AS Professor,
    MAX(CASE WHEN occupation = 'Singer' THEN name END) AS Singer,
    MAX(CASE WHEN occupation = 'Actor' THEN name END) AS Actor
FROM base
GROUP BY
    row_num
ORDER BY
    row_num