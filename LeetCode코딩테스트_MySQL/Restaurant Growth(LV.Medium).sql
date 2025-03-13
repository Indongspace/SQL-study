WITH base AS (
    SELECT
        visited_on,
        SUM(amount) AS amount
    FROM customer
    GROUP BY
        visited_on
)
SELECT
    visited_on,
    amount,
    average_amount
FROM (
    SELECT
        visited_on,
        LAG(visited_on, 6) OVER(ORDER BY visited_on) AS grp_day,
        SUM(amount) OVER(ORDER BY visited_on ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS amount,
        ROUND(AVG(amount) OVER(ORDER BY visited_on ROWS BETWEEN 6 PRECEDING AND CURRENT ROW), 2) AS average_amount
    FROM base
) AS a
WHERE
    grp_day IS NOT NULL
ORDER BY
    visited_on
    