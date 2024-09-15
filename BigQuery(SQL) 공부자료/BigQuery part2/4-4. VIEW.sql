# VIEW 생성하는 방법 : SQL 쿼리를 실행한 후, 뷰 저장하기
-- SELECT
--   event_date,
--   COUNT(*) AS dau
-- FROM advanced.app_logs
-- GROUP BY ALL
-- ORDER BY
--   event_date

# VIEW 생성하는 방법 : CREATE 문을 사용해 뷰 생성하기
-- CREATE OR REPLACE VIEW advanced.dau_view2 AS
-- SELECT
--   event_date,
--   COUNT(*) AS dau
-- FROM advanced.app_logs
-- GROUP BY ALL
-- ORDER BY
--   event_date

# VIEW 사용하기
# 일반적으로 쿼리하듯 사용할 수 있음
SELECT
  event_date,
  dau1
FROM advanced.dau_view




