WITH challenge_cnt AS (
    SELECT
        hacker_id,
        COUNT(challenge_id) AS cnt
    FROM challenges
    GROUP BY
        hacker_id
), max_cnt AS (  
    SELECT
        MAX(cnt) AS max_cnt
    FROM challenge_cnt
)
SELECT
    hac.hacker_id,
    hac.name,
    chacn.cnt
FROM challenge_cnt AS chacn
INNER JOIN hackers AS hac
ON chacn.hacker_id = hac.hacker_id
WHERE
    chacn.cnt NOT IN (SELECT cnt FROM challenge_cnt GROUP BY cnt HAVING COUNT(*) > 1) OR
    chacn.cnt >= (SELECT max_cnt FROM max_cnt)
ORDER BY
    cnt DESC,
    hacker_id
    