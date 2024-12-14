SELECT
    CONCAT(name, '(', LEFT(occupation, 1), ')') AS name_with_occupation
FROM occupations
ORDER BY
    name ASC;
SELECT
    CONCAT('There are a total of ', COUNT(name), ' ', LOWER(occupation), 's.') AS occupation_cnt
FROM occupations
GROUP BY
    occupation
ORDER BY
    COUNT(name),
    occupation