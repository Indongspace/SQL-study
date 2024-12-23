SELECT
    product_id,
    product_name,
    SUM(sales) AS total_sales
FROM (
    SELECT
        p.product_id,
        p.product_name,
        o.amount * p.price AS sales
    FROM food_product AS p
    INNER JOIN food_order AS o
    ON p.product_id = o.product_id
    WHERE
        DATE_FORMAT(o.produce_date, '%Y-%m') = '2022-05'
) AS base
GROUP BY
    product_id
ORDER BY
    total_sales DESC, product_id ASC 
    