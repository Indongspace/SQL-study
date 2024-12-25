WITH review_count AS (
    SELECT
        m.member_id,
        COUNT(*) AS review_cnt
    FROM member_profile AS m
    INNER JOIN rest_review AS r
    ON m.member_id = r.member_id
    GROUP BY
        m.member_id
), max_review_id AS (
    SELECT
        member_id
    FROM review_count
    WHERE
        review_cnt = (SELECT MAX(review_cnt) FROM review_count)
)
SELECT
    m.member_name,
    r.review_text,
    DATE_FORMAT(r.review_date, '%Y-%m-%d') AS review_date
FROM member_profile AS m
INNER JOIN rest_review AS r
ON m.member_id = r.member_id
WHERE
    m.member_id IN (SELECT member_id FROM max_review_id)
ORDER BY
    review_date ASC, review_text ASC 
    