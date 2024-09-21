# 하루 일자의 데이터
-- SELECT  
--   event_date,
--   COUNT(DISTINCT user_pseudo_id) AS dau
-- FROM `firebase-public-project.analytics_153293282.events_20181003` 
-- GROUP BY
--   event_date
-- ORDER BY
--   event_date
-- LIMIT 1000

# 여러 일자의 데이터
# event_*
# WHERE _table_suffix 사용
# 스캔하는 용량 꼭 주의
SELECT
  event_date,
  COUNT(DISTINCT user_pseudo_id) AS dau
FROM `firebase-public-project.analytics_153293282.events_*`
WHERE
  _table_suffix BETWEEN '20180901' AND '20180920'
GROUP BY
  event_date
ORDER BY
  event_date

