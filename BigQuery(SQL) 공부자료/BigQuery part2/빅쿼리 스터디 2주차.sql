# 윈도우 함수(탐색 함수) 연습 문제 1
-- SELECT
--   *,
--   LEAD(visit_month, 1) OVER(PARTITION BY user_id ORDER BY visit_month ASC) AS lead_1,
--   LEAD(visit_month, 2) OVER(PARTITION BY user_id ORDER BY visit_month ASC) AS lead_2
-- FROM advanced.analytics_function_01
-- ORDER BY
--   user_id;

# 윈도우 함수(탐색 함수) 연습 문제 2
-- SELECT
--   *,
--   LEAD(visit_month, 1) OVER(PARTITION BY user_id ORDER BY visit_month ASC) AS lead_1,
--   LEAD(visit_month, 2) OVER(PARTITION BY user_id ORDER BY visit_month ASC) AS lead_2,
--   LAG(visit_month, 1) OVER(PARTITION BY user_id ORDER BY visit_month ASC) AS lag_1
-- FROM advanced.analytics_function_01
-- ORDER BY
--   user_id;

# 1) 사용자별 쿼리를 실행한 총 횟수를 구하는 쿼리를 작성해주세요. 단, GROUP BY를 사용해서 집계하는 것이 아닌 query_logs의 데이터의 우측에 새로운 컬럼을 만들어주세요.
-- SELECT
--   *,
--   COUNT(user) OVER(PARTITION BY user) AS total_query_cnt
-- FROM advanced.query_logs
-- ORDER BY
--   query_date

# 2) 주차별로 팀 내에서 쿼리를 많이 실행한 수를 구한 후, 실행한 수를 활용해 랭킹을 구해주세요. 단, 랭킹이 1등인 사람만 결과가 보이도록 해주세요
-- WITH base AS (
--   SELECT
--     EXTRACT(WEEK FROM query_date) AS week_number,
--     team,
--     user,
--     COUNT(user) AS query_cnt
--   FROM advanced.query_logs
--   GROUP BY ALL
-- )
-- SELECT
--   *,
--   RANK() OVER(PARTITION BY week_number, team ORDER BY query_cnt DESC) AS team_rank
-- FROM base
-- QUALIFY team_rank = 1
-- ORDER BY
--   week_number, team 

# 3) (2번 문제에서 사용한 주차별 쿼리 사용) 쿼리를 실행한 시점 기준 1주 전에 쿼리 실행 수를 별도의 컬럼으로 확인할 수 있는 쿼리를 작성해주세요
-- WITH base AS (
--   SELECT
--     EXTRACT(WEEK FROM query_date) AS week_number,
--     team,
--     user,
--     COUNT(user) AS query_cnt
--   FROM advanced.query_logs
--   GROUP BY ALL
-- )
-- SELECT
--   user,
--   team,
--   week_number,
--   query_cnt,
--   LAG(query_cnt, 1) OVER(PARTITION BY user ORDER BY week_number) AS prev_week_query_cnt
-- FROM base

# 4) 시간의 흐름에 따라, 일자별로 유저가 실행한 누적 쿼리 수를 작성해주세요
-- WITH base AS (
--   SELECT
--     user,
--     team,
--     query_date,
--     COUNT(user) AS query_cnt
--   FROM advanced.query_logs
--   GROUP BY ALL
-- )
-- SELECT
--   *,
--   SUM(query_cnt) OVER(PARTITION BY user ORDER BY query_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_query_count
-- FROM base

# 5) 다음 데이터는 주문 횟수를 나타낸 데이터입니다. 만약 주문 횟수가 없으면 NULL로 기록됩니다. 이런 데이터에서 NULL값이라고 되어있는 부분을 바로 이전 날짜의 값으로 채워주는 쿼리를 작성해주세요
-- WITH raw_data AS (
--  SELECT DATE'2024-05-01'AS date, 15 AS number_of_orders UNION ALL
--  SELECT DATE'2024-05-02', 13 UNION ALL
--  SELECT DATE'2024-05-03', NULL UNION ALL
--  SELECT DATE'2024-05-04', 16 UNION ALL
--  SELECT DATE'2024-05-05', NULL UNION ALL
--  SELECT DATE'2024-05-06', 18 UNION ALL
--  SELECT DATE'2024-05-07', 20 UNION ALL
--  SELECT DATE'2024-05-08', NULL UNION ALL
--  SELECT DATE'2024-05-09', 13 UNION ALL
--  SELECT DATE'2024-05-10', 14 UNION ALL
--  SELECT DATE'2024-05-11', NULL UNION ALL
--  SELECT DATE'2024-05-12', NULL
-- )
-- SELECT
--   *,
--   IFNULL(number_of_orders, LAG(number_of_orders,1) OVER(ORDER BY date ASC)) AS non_null
-- FROM raw_data;
-- SELECT
--   *,
--   LAST_VALUE(number_of_orders IGNORE NULLS) OVER(ORDER BY date ASC) AS non_null
-- FROM raw_data

# 6) 5번 문제에서 NULL을 채운 후, 2일 전 ~ 현재 데이터의 평균을 구하는 쿼리를 작성해주세요(이동 평균)
-- WITH raw_data AS (
--  SELECT DATE'2024-05-01'AS date, 15 AS number_of_orders UNION ALL
--  SELECT DATE'2024-05-02', 13 UNION ALL
--  SELECT DATE'2024-05-03', NULL UNION ALL
--  SELECT DATE'2024-05-04', 16 UNION ALL
--  SELECT DATE'2024-05-05', NULL UNION ALL
--  SELECT DATE'2024-05-06', 18 UNION ALL
--  SELECT DATE'2024-05-07', 20 UNION ALL
--  SELECT DATE'2024-05-08', NULL UNION ALL
--  SELECT DATE'2024-05-09', 13 UNION ALL
--  SELECT DATE'2024-05-10', 14 UNION ALL
--  SELECT DATE'2024-05-11', NULL UNION ALL
--  SELECT DATE'2024-05-12', NULL
--  )
-- SELECT
--   *,
--   AVG(number_of_orders) OVER(ORDER BY date ASC ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS moving_avg
-- FROM (
--   SELECT
--     date,
--     LAST_VALUE(number_of_orders IGNORE NULLS) OVER(ORDER BY date) AS number_of_orders
--   FROM raw_data
-- )

# 7) app_logs 테이블에서 Custom Session을 만들어 주세요. 이전 이벤트 로그와 20초가 지나면 새로운 Session을 만들어 주세요. Session은 숫자로(1,2,3...) 표시해도 됩니다
# 2022-08-18일의 user_pseudo_id(1997494153.8491999091)은 session_id가 4까지 나옵니다
WITH base AS (
  SELECT
    event_date,
    DATETIME(TIMESTAMP_MICROS(event_timestamp), 'Asia/Seoul') AS event_datetime,
    event_name,
    user_id,
    user_pseudo_id
  FROM advanced.app_logs
  WHERE
    event_date = '2022-08-18' AND
    user_pseudo_id = '1997494153.8491999091'
), diff_data AS (
  SELECT
    *,
    DATETIME_DIFF(event_datetime, before_1_event_datetime, SECOND) AS second_diff
  FROM (
    SELECT
      *,
      LAG(event_datetime, 1) OVER(PARTITION BY user_pseudo_id ORDER BY event_datetime ASC) AS before_1_event_datetime
    FROM base
  )
)
SELECT
  *,
  SUM(session_start) OVER(PARTITION BY user_pseudo_id ORDER BY event_datetime ASC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS session_id 
FROM (
  SELECT
    *,
    CASE
      WHEN second_diff IS NULL THEN 1
      WHEN second_diff >= 20 THEN 1
      ELSE NULL
    END AS session_start
  FROM diff_data
)


