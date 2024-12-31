WITH base AS (
    SELECT
        c.car_id,
        c.car_type,
        c.daily_fee,
        h.history_id,
        DATEDIFF(h.end_date, h.start_date) + 1 AS date_diff,
        CASE
            WHEN DATEDIFF(h.end_date, h.start_date) + 1 BETWEEN 7 AND 29 THEN '7일 이상'
            WHEN DATEDIFF(h.end_date, h.start_date) + 1 BETWEEN 30 AND 89 THEN '30일 이상'
            WHEN DATEDIFF(h.end_date, h.start_date) + 1 >= 90 THEN '90일 이상'
            ELSE 'NULL'
        END AS duration_type
    FROM CAR_RENTAL_COMPANY_CAR AS c
    INNER JOIN CAR_RENTAL_COMPANY_RENTAL_HISTORY AS h
    ON c.car_id = h.car_id
    WHERE
        c.car_type = '트럭'
)
SELECT
    b.history_id,
    CASE
        WHEN b.duration_type != 'NULL' THEN ROUND(b.daily_fee * b.date_diff * (1- (d.discount_rate / 100)))
        ELSE ROUND(b.daily_fee * b.date_diff)
    END AS fee
FROM base AS b
LEFT JOIN (SELECT * FROM CAR_RENTAL_COMPANY_DISCOUNT_PLAN WHERE car_type = '트럭') AS d
ON b.duration_type = d.duration_type
ORDER BY
    fee DESC, history_id DESC
