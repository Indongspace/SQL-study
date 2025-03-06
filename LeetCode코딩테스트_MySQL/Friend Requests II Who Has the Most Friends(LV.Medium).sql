WITH ids AS (
    SELECT requester_id AS id FROM requestaccepted
    UNION ALL
    SELECT accepter_id FROM requestaccepted
)
SELECT
    id,
    COUNT(*) AS num
FROM ids
GROUP BY
    id
ORDER BY
    num DESC
LIMIT 1
