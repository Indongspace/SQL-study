SELECT
    c.car_id,
    c.car_type,
    c.daily_fee,
    h.start_date,
    h.end_date
FROM CAR_RENTAL_COMPANY_CAR AS c
LEFT JOIN CAR_RENTAL_COMPANY_RENTAL_HISTORY AS h
ON c.car_id = h.car_id
WHERE
    c.car_type = '세단' OR c.car_type = 'SUV' AND
    h.start_date <= '2022-11-30' AND h.end_date >= '2022-11-01'
    