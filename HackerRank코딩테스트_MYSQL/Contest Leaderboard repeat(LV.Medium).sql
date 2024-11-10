SELECT
    hac.hacker_id,
    hac.name,
    sum_score.score
FROM (
    SELECT
        hacker_id,
        SUM(max_score) AS score
    FROM (
        SELECT
            hacker_id,
            challenge_id,
            MAX(score) AS max_score
        FROM submissions
        GROUP BY
            hacker_id,
            challenge_id
    ) AS max_score
    GROUP BY
        hacker_id
) AS sum_score
INNER JOIN hackers AS hac
ON sum_score.hacker_id = hac.hacker_id
WHERE
    sum_score.score > 0
ORDER BY
    score DESC,
    hacker_id ASC
