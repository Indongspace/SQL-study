WITH base AS (
    SELECT
        *
    FROM food_product
    WHERE
        category IN ('과자', '국', '김치', '식용유')
)
SELECT
    category,
    price AS max_price,
    product_name
FROM base
WHERE
    price = (SELECT MAX(price) FROM base AS sub WHERE sub.category = base.category)
ORDER BY
    max_price DESC 