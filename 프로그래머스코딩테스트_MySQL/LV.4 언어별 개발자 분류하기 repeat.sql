SELECT
    *
FROM (
SELECT
    CASE
        WHEN skill_code & (SELECT SUM(code) FROM skillcodes WHERE category = 'Front End') != 0 AND 
             skill_code & (SELECT code FROM skillcodes WHERE name = 'Python') != 0 THEN 'A'
        WHEN skill_code & (SELECT code FROM skillcodes WHERE name = 'C#') != 0 THEN 'B'
        WHEN skill_code & (SELECT SUM(code) FROM skillcodes WHERE category = 'Front End') != 0 THEN 'C'
        ELSE NULL
    END AS grade,
    id,
    email
FROM developers
) AS base
WHERE
    grade IS NOT NULL
ORDER BY
    grade, id
    