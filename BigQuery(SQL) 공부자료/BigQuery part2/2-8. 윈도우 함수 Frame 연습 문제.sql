-- amount_total, cumulative_sum, cumulative_sum_by_user, last_5_orders_avg_amount
SELECT
  *,
  SUM(amount) OVER () AS amount_total,
  SUM(amount) OVER (ORDER BY order_id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_sum,
  SUM(amount) OVER (PARTITION BY user_id ORDER BY order_id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_sum_by_user,
  AVG(amount) OVER (ORDER BY order_id ROWS BETWEEN 5 PRECEDING AND 1 PRECEDING) AS last_5_orders_avg_amount
FROM advanced.orders
# 21년 4월에 나온 QUALIFY
-- QUALIFY
--   user_id = 1
ORDER BY
  order_id
