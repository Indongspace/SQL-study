SELECT
    hackers.hacker_id,
    hackers.name
FROM (
SELECT
    hacker_id,
    COUNT(challenge_id) AS max_count
FROM (
    SELECT
        sub.hacker_id,
        sub.challenge_id,
        cha.difficulty_level,
        sub.score,
        dif.score AS max_score
    FROM submissions AS sub
    INNER JOIN challenges AS cha
    ON sub.challenge_id = cha.challenge_id
    INNER JOIN difficulty AS dif
    ON cha.difficulty_level = dif.difficulty_level
    WHERE
        sub.score = dif.score
) AS hacker_max_get
GROUP BY
    hacker_id
HAVING
    COUNT(challenge_id) > 1
) AS max_count
INNER JOIN hackers
ON max_count.hacker_id = hackers.hacker_id
ORDER BY
    max_count DESC,
    hacker_id ASC
