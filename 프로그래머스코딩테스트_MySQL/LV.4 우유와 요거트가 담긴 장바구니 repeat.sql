WITH milk AS (
    SELECT
        cart_id
    FROM cart_products
    WHERE
        name IN ('Milk')
), yogurt AS (
    SELECT
        cart_id
    FROM cart_products
    WHERE
        name IN ('Yogurt')
)
SELECT
    DISTINCT m.cart_id
FROM milk AS m
INNER JOIN yogurt AS y
ON m.cart_id = y.cart_id 
ORDER BY
    cart_id 