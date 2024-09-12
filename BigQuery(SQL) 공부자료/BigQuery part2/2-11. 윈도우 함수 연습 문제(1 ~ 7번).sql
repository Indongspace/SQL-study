# 1) 사용자별 쿼리를 실행한 총 횟수를 구하는 쿼리를 작성해주세요. 단, GROUP BY를 사용해서 집계하는 것이 아닌 query_logs의 데이터의 우측에 새로운 컬럼을 만들어주세요.
-- SELECT
--   *,
--   COUNT(user) OVER(PARTITION BY user) AS cnt
-- FROM advanced.query_logs
-- ORDER BY
--   user,
--   query_date

# 2) 주차별로 팀 내에서 쿼리를 많이 실행한 수를 구한 후, 실행한 수를 활용해 랭킹을 구해주세요. 단, 랭킹이 1등인 사람만 결과가 보이도록 해주세요
-- 주차별로 개인당 실행한 쿼리 횟수
-- 위 쿼리 횟수를 기반으로 랭킹
-- 랭킹을 기반으로 필터링(랭킹 = 1)
-- WITH query_cnt_by_team AS (
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
--   RANK() OVER(PARTITION BY week_number, team ORDER BY query_cnt DESC) AS rk
-- FROM query_cnt_by_team
-- QUALIFY
--   rk = 1
-- ORDER BY
--   week_number,
--   team,
--   query_cnt DESC
-- 문제의 의도 : 원본 데이터 => 1 row 마다 데이터가 있고, 그걸 집계해서 사용. GROUP BY => 윈도우 함수

# 3) (2번 문제에서 사용한 주차별 쿼리 사용) 쿼리를 실행한 시점 기준 1주 전에 쿼리 실행 수를 별도의 컬럼으로 확인할 수 있는 쿼리를 작성해주세요
-- WITH query_cnt_by_team AS (
--   SELECT
--     EXTRACT(WEEK FROM query_date) AS week_number,
--     user,
--     team,
--     COUNT(query_date) AS query_count
--   FROM advanced.query_logs
--   GROUP BY ALL
-- )
-- SELECT
--   user,
--   team,
--   week_number,
--   query_count,
--   LAG(query_count) OVER(PARTITION BY user ORDER BY week_number) AS prev_week_query_count
-- FROM query_cnt_by_team
-- ORDER BY
--   user, team, week_number

# 4) 시간의 흐름에 따라, 일자별로 유저가 실행한 누적 쿼리 수를 작성해주세요
-- 누적 쿼리 : 과거의 시간부터 current row까지
-- Frame의 Default값 : UNBOUNDED PRECEDING ~ CURRENT ROW
-- SELECT
--   *,
--   SUM(query_count) OVER(PARTITION BY user ORDER BY query_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_query_count
-- FROM (
-- SELECT
--   *,
--   COUNT(user) AS query_count
-- FROM advanced.query_logs
-- GROUP BY ALL
-- )
-- ORDER BY
--   user, query_date

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
--  )
-- -- SELECT
-- --   *,
-- --   IFNULL(number_of_orders, LAG(number_of_orders, 1) OVER(ORDER BY date)) AS number_of_orders
-- -- FROM raw_data
-- SELECT
--   *,
--   LAST_VALUE(number_of_orders IGNORE NULLS) OVER(ORDER BY date) AS number_of_orders2
-- FROM raw_data
-- -- FIRST_VALUE, LAST_VALUE => NULL을 포함해서 연산
-- -- NULL을 제외해서 연산하고 싶으면 IGNORE NULLS

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
--   AVG(number_of_orders) OVER(ORDER BY date ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS moving_avg
-- FROM (
--   SELECT
--     date,
--     LAST_VALUE(number_of_orders IGNORE NULLS) OVER(ORDER BY date) AS number_of_orders
--   FROM raw_data
-- )

# 7) app_logs 테이블에서 Custom Session을 만들어 주세요. 이전 이벤트 로그와 20초가 지나면 새로운 Session을 만들어 주세요. Session은 숫자로 (1,2,3 ...) 표시해도 됩니다
# 2022-08-18일의 user_pseudo_id(1997494153.8491999091)은 session_id가 4까지 나옵니다
-- WITH base AS (
--   SELECT
--     event_date,
--     DATETIME(TIMESTAMP_MICROS(event_timestamp), 'Asia/Seoul') AS event_datetime, 
--     event_name,
--     user_id,
--     user_pseudo_id
--   FROM advanced.app_logs
--   # WHERE 조건에 이벤트를 필터링해서 계산해도 됨.
--   -- WHERE
--   --   event_date = '2022-08-18' AND
--   --   user_pseudo_id = '1997494153.8491999091'
-- ), diff_data AS (
--   SELECT
--     *,
--     DATETIME_DIFF(event_datetime, prev_event_datetime, SECOND) AS second_diff
--     # second_diff 기반으로 새로운 세션의 시작일지, 아닐지를 판단할 수 있
--   FROM (
--     SELECT
--       *,
--       LAG(event_datetime, 1) OVER(PARTITION BY user_pseudo_id ORDER BY event_datetime) AS prev_event_datetime
--       # event_datetime과 prev_event_datetime을 빼서 20초가 넘으면 새로운 세션으로 정의. 20초가 넘지 않으면 기존 세션
--       # DATETIME_DIFF() => 차이를 구할 수 있음
--     FROM base
--   )
-- )
-- SELECT  
--   *,
--   # 누적합을 사용해서 session_number를 만들었
--   SUM(session_start) OVER(PARTITION BY user_pseudo_id ORDER BY event_datetime) AS session_num
--   # session을 구할 때 쿼리가 길어질 수 있음. 하루에 접속을 여러 번 하는 서비스 => session 기반이 좋을 수 있고, 아니라고 하면 일자별 유저 집계가 나을 수 있다.
-- FROM (
--   SELECT
--     *,
--     CASE
--       WHEN prev_event_datetime IS NULL THEN 1
--       WHEN second_diff >= 20 THEN 1 # session을 나누는 기준 초. 데이터를 탐색하면서 결정. 보통 앱 로그에서는 30초, 60초 
--       ELSE NULL
--     END AS session_start
--     # session이 시작됨을 알리는 session_start
--   FROM diff_data
--   ORDER BY
--     event_datetime 
-- )
-- 세션 정리
-- 이전 이벤트 로그와 현재 이벤트 로그의 diff => 초나 분을 구한다
-- 그 기준을 가지고 기준보다 높으면 새로운 세션이라고 생각한다
-- 첫번째 값엔 null이 있을 수 있어서, 이 부분도 챙겨야 한다
-- 새로운 세션. session_start 값을 기반으로 누적합 => session_num이 된다
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
    DATETIME_DIFF(event_datetime, before_event_datetime, SECOND) AS second_diff
  FROM (
    SELECT
      *,
      LAG(event_datetime, 1) OVER(PARTITION BY user_pseudo_id ORDER BY event_datetime) AS before_event_datetime
    FROM base
  )
)
SELECT
  *,
  SUM(session_start) OVER(PARTITION BY user_pseudo_id ORDER BY event_datetime ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS session_id 
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
ORDER BY
  event_datetime
