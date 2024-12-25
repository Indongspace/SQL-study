WITH base AS (
    SELECT
        m.member_id,
        m.member_name,
        r.review_text,
        r.review_date
    FROM member_profile AS m
    INNER JOIN rest_review AS r
    ON m.member_id = r.member_id
), most_review AS (
    SELECT
        member_id,
        COUNT(*) AS review_cnt
    FROM base
    GROUP BY
        member_id
    ORDER BY
        review_cnt DESC
    LIMIT 1   
)
SELECT
    b.member_name,
    b.review_text,
    DATE_FORMAT(b.review_date, '%Y-%m-%d') AS review_date
FROM base AS b
INNER JOIN most_review AS m
ON b.member_id = m.member_id
ORDER BY
    review_date ASC, review_text ASC