-- amount_total : 전체 SUM
-- cumulative_sum : row 시점에 누적 SUM
-- cumulative_sum_by_user : row 시점에 유저별 누적 SUM
-- last_5_orders_avg_amount : order_id 기준으로 정렬하고, 직전 5개의 주문의 평균 amount
-- 집계분석함수(컬럼) OVER(PARTITION BY ~~~ ORDER BY ~~~ ROWS BETWEEN A and B)

SELECT
  *,
  SUM(amount) OVER() AS amount_total, # OVER 안에 아무것도 들어가지 않는 경우도 있구나!
  SUM(amount) OVER(ORDER BY order_id) AS cumulative_sum,
  SUM(amount) OVER(PARTITION BY user_id ORDER BY order_id) AS cumulative_sum_by_user,
  AVG(amount) OVER(ORDER BY order_id ROWS BETWEEN 5 PRECEDING AND 1 PRECEDING) AS last_5_orders_avg_amount
FROM advanced.orders
ORDER BY order_id
-- ORDER BY user_id, order_date