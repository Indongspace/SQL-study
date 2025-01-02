WITH nov_able AS (
    SELECT
        *
    FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY 
    WHERE
        end_date >= '2022-11-01' AND start_date <= '2022-11-30'
), base AS (
    SELECT
        c.car_id,
        c.car_type,
        c.daily_fee,
        n.start_date,
        n.end_date
    FROM CAR_RENTAL_COMPANY_CAR AS c
    LEFT JOIN nov_able AS n
    ON c.car_id = n.car_id
    WHERE
        car_type = '세단' OR car_type = 'SUV'
)
SELECT
    b.car_id,
    b.car_type,
    ROUND(b.daily_fee * 30 * (1 - (d.discount_rate / 100))) AS fee
FROM base AS b
INNER JOIN (SELECT * FROM CAR_RENTAL_COMPANY_DISCOUNT_PLAN WHERE duration_type = '30일 이상') AS d
ON b.car_type = d.car_type
WHERE
    start_date IS NULL AND
    ROUND(b.daily_fee * 30 * (1 - (d.discount_rate / 100))) >= 500000 AND
    ROUND(b.daily_fee * 30 * (1 - (d.discount_rate / 100))) < 2000000
ORDER BY
    fee DESC, car_type ASC, car_id DESC
