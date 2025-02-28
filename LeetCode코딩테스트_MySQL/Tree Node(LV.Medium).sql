SELECT
    id,
    CASE
        WHEN p_id IS NULL THEN 'Root'
        WHEN p_id IN (SELECT id FROM tree) AND id IN (SELECT p_id FROM tree) THEN 'Inner'
        ELSE 'Leaf'
    END AS type
FROM tree