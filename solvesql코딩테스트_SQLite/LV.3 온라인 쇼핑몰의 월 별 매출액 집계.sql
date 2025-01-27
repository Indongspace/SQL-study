WITH oa AS (
  SELECT
    order_month,
    SUM(ordered_amount) AS ordered_amount
  FROM (
    SELECT
      o.order_id,
      strftime('%Y-%m', o.order_date) AS order_month,
      i.price * i.quantity AS ordered_amount
    FROM orders AS o 
    INNER JOIN order_items AS i 
    ON o.order_id = i.order_id 
    WHERE
      SUBSTR(o.order_id, 1, 1) != 'C'
  )
  GROUP BY
    order_month
), ca AS (
  SELECT
    order_month,
    SUM(canceled_amount) AS canceled_amount
  FROM (
    SELECT
      o.order_id,
      strftime('%Y-%m', o.order_date) AS order_month,
      i.price * i.quantity AS canceled_amount
    FROM orders AS o 
    INNER JOIN order_items AS i 
    ON o.order_id = i.order_id 
    WHERE
      SUBSTR(o.order_id, 1, 1) = 'C'
  )
  GROUP BY
    order_month
)
SELECT
  oa.order_month,
  oa.ordered_amount,
  ca.canceled_amount,
  oa.ordered_amount + ca.canceled_amount AS total_amount
FROM oa
LEFT JOIN ca 
ON oa.order_month = ca.order_month
ORDER BY
  oa.order_month ASC 