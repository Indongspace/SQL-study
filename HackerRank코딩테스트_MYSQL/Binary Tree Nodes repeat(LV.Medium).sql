SELECT
    n,
    CASE
        WHEN p IS NULL THEN 'Root'
        WHEN n NOT IN (SELECT p FROM bst WHERE p IS NOT NULL) THEN 'Leaf'
        ELSE 'Inner'
    END AS node
FROM bst
ORDER BY
    n