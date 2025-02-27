WITH price_by_op AS (
SELECT
    stock_name,
    CASE
        WHEN operation = 'Buy' THEN price_by_op * -1
        WHEN operation = 'Sell' THEN price_by_op 
    END AS price_by_op
FROM (
    SELECT
        stock_name,
        operation,
        SUM(price) AS price_by_op
    FROM stocks
    GROUP BY
        stock_name, operation
) AS base
)
SELECT
    stock_name,
    SUM(price_by_op) AS capital_gain_loss
FROM price_by_op
GROUP BY
    stock_name