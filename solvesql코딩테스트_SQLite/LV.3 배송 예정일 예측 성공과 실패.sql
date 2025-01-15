WITH base AS (
  SELECT
    *
  FROM olist_orders_dataset
  WHERE
    strftime('%Y-%m', order_purchase_timestamp) = '2017-01' AND
    order_delivered_customer_date IS NOT NULL AND order_estimated_delivery_date IS NOT NULL 
), success_and_fail AS (
  SELECT
    strftime('%Y-%m-%d', order_purchase_timestamp) AS purchase_date,
    CASE
      WHEN order_delivered_customer_date <= order_estimated_delivery_date THEN 1
      ELSE 0
    END AS success_and_fail
  FROM base
), success AS (
  SELECT
    purchase_date,
    SUM(success_and_fail) AS success 
  FROM success_and_fail
  GROUP BY
    purchase_date 
), fail AS (
  SELECT
    purchase_date,
    COUNT(success_and_fail) AS fail 
  FROM success_and_fail 
  WHERE
    success_and_fail = 0
  GROUP BY
    purchase_date 
)
SELECT
  s.purchase_date,
  s.success,
  CASE
    WHEN f.fail IS NULL THEN 0
    ELSE f.fail
  END AS fail  
FROM success AS s 
LEFT JOIN fail AS f 
ON s.purchase_date = f.purchase_date
ORDER BY
  s.purchase_date ASC 
