SELECT
    id,
    email,
    first_name,
    last_name
FROM DEVELOPERS 
WHERE
    skill_code & (SELECT SUM(code) FROM SKILLCODES WHERE category = 'Front End') != 0
ORDER BY
    id 
    