-- CREATE OR REPLACE TABLE advanced.analytics_function_01 AS(
--  SELECT 1004 AS user_id, 1 AS visit_month UNION ALL
--  SELECT 1004, 3 UNION ALL
--  SELECT 1004, 7 UNION ALL
--  SELECT 1004, 8 UNION ALL
--  SELECT 2112, 3 UNION ALL
--  SELECT 2112, 6 UNION ALL
--  SELECT 2112, 7 UNION ALL
--  SELECT 3912, 4
-- )

# 문제 1) user들의 다음 접속 월과 다다음 접속 월을 구하는 쿼리를 작성해주세요.
# 윈도우 함수
# 탐색 함수 : LEAD, LAG, FIRST_VALUE, LAST_VALUE
# LEAD, LAG -> 함수(컬럼, 순서). 순서를 명시하지 않으면 Default는 1
-- SELECT
--   *,
--   LEAD(visit_month) OVER (PARTITION BY user_id ORDER BY visit_month) AS next_month,
--   LEAD(visit_month, 2) OVER (PARTITION BY user_id ORDER BY visit_month) AS next_two_month
-- FROM `advanced.analytics_function_01`

# 문제 2) user들의 다음 접속 월과 다다음 접속 월, 이전 접속 월을 구하는 쿼리를 작성해주세요
-- SELECT
--   *,
--   LEAD(visit_month) OVER (PARTITION BY user_id ORDER BY visit_month) AS next_month,
--   LEAD(visit_month, 2) OVER (PARTITION BY user_id ORDER BY visit_month) AS next_two_month,
--   LAG(visit_month) OVER (PARTITION BY user_id ORDER BY visit_month) AS before_month
-- FROM `advanced.analytics_function_01`
# LAG 함수(1)를 사용할 때 NULL이 나온다 => 그 값은 처음이다!
# LEAD 함수(1)를 사용할 때 NULL이 나온다 => 그 값은 마지막이다!

# 문제 3) user가 접속했을 때, 다음 접속까지의 간격을 구하시오
-- SELECT
--   *,
--   LEAD(visit_month) OVER (PARTITION BY user_id ORDER BY visit_month) AS after_visit_month,
--   LEAD(visit_month) OVER (PARTITION BY user_id ORDER BY visit_month) - visit_month AS diff_month
--   # 윈도우 함수를 이렇게 쓰는게 좋을까? => 중복된 쿼리는 줄이는 것이 좋을 수 있음
--   # 쿼리를 수정할 상황이 생긴다면 => 2번 수정 => 굉장히 많아지면 복잡해지고, 실수하기 좋음
-- FROM `advanced.analytics_function_01`
-- ORDER BY
--   user_id, visit_month

# 쿼리를 덜 수정할 수 있는 구조를 만들면 좋겠다!
-- SELECT
--   *,
--   after_visit_month - visit_month AS diff_month
-- FROM (
--   SELECT
--     *,
--     LEAD(visit_month) OVER (PARTITION BY user_id ORDER BY visit_month) AS after_visit_month
--   FROM `advanced.analytics_function_01`
--   ORDER BY
--     user_id, visit_month
-- )

# 문제 4) 이 데이터셋을 기준으로 user_id의 첫번째 방문 월, 마지막 방문 월을 구하는 쿼리를 작성해주세요
SELECT
  *,
  FIRST_VALUE(visit_month) OVER (PARTITION BY user_id ORDER BY visit_month) AS first_month,
  LAST_VALUE(visit_month) OVER (PARTITION BY user_id ORDER BY visit_month ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_month
FROM `advanced.analytics_function_01`

