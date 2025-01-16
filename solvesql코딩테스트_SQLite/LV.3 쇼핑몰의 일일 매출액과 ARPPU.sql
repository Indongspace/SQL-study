WITH base AS (
  SELECT
    strftime('%Y-%m-%d', o.order_purchase_timestamp) AS dt,
    o.order_id,
    o.customer_id,
    p.payment_value
  FROM olist_orders_dataset AS o
  INNER JOIN olist_order_payments_dataset AS p 
  ON o.order_id = p.order_id 
  WHERE
    o.order_purchase_timestamp >= '2018-01-01'
)
SELECT
  dt,
  pu,
  ROUND(revenue_daily, 2) AS revenue_daily,
  ROUND((revenue_daily / pu), 2) AS arppu
FROM (
  SELECT
    dt,
    COUNT(DISTINCT customer_id) AS pu,
    SUM(payment_value) AS revenue_daily
  FROM base
  GROUP BY
    dt 
)
ORDER BY
  dt ASC 