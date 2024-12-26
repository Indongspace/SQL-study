WITH base AS (
    SELECT
        u.user_id,
        u.gender,
        YEAR(o.sales_date) AS year,
        MONTH(o.sales_date) AS month
    FROM user_info AS u
    INNER JOIN online_sale AS o
    ON u.user_id = o.user_id
    WHERE
        u.gender IS NOT NULL 
)
SELECT
    year,
    month,
    gender,
    COUNT(DISTINCT user_id) AS users
FROM base
GROUP BY
    year, month, gender
ORDER BY 
    year, month, gender
    