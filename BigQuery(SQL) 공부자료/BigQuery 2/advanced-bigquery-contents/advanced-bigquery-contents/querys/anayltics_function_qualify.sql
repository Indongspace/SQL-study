-- SELECT
--   *
-- FROM (
--   SELECT
--     order_id,
--     order_date,
--     user_id,
--     amount,
--     SUM(amount) OVER (PARTITION BY user_id) AS amount_total
--   FROM advanced.orders
--   )
-- WHERE
--   amount_total >= 500
-- Unrecognized name: amount_total at [9:3]

# 21년 4월에 나온 QUALIFY
SELECT
  order_id,
  order_date,
  user_id,
  amount,
  SUM(amount) OVER (PARTITION BY user_id) AS amount_total
FROM advanced.orders
QUALIFY amount_total >= 500

