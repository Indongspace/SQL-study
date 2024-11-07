WITH A AS (
    SELECT
        task_id,
        start_date
    FROM projects
    WHERE
        start_date NOT IN (SELECT end_date FROM projects)
), B AS (
    SELECT
        task_id,
        end_date
    FROM projects
    WHERE
        end_date NOT IN (SELECT start_date FROM projects)
)
SELECT
    start_date,
    MIN(end_date)
FROM A,B
WHERE
    start_date < end_date
GROUP BY
    start_date
ORDER BY
    MIN(end_date) - start_date ASC,
    start_date ASC
