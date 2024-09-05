# 퍼널 데이터
SELECT
  event_date,
  CONCAT(param.key, '-', param.value.string_value) AS event_name_with_screen,
  CASE
    WHEN CONCAT(param.key, '-', param.value.string_value) LIKE '%welcome%' THEN 1
    WHEN CONCAT(param.key, '-', param.value.string_value) LIKE '%home%' THEN 2
    WHEN CONCAT(param.key, '-', param.value.string_value) LIKE '%food_category%' THEN 3
    WHEN CONCAT(param.key, '-', param.value.string_value) LIKE '%restaurant%' THEN 4
    WHEN CONCAT(param.key, '-', param.value.string_value) LIKE '%screen_view-cart%' THEN 5
    WHEN CONCAT(param.key, '-', param.value.string_value) LIKE '%click_payment-cart%' THEN 6
  END AS step_number,
  COUNT(user_pseudo_id) AS cnt
FROM advanced.app_logs
CROSS JOIN UNNEST(event_params) AS param
WHERE
  event_date = '2022-08-01' AND
  event_name IN ('screen_view', 'click_payment')
GROUP BY ALL
LIMIT 100
