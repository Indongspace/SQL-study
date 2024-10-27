-- CREATE OR REPLACE TABLE advanced.array_exercises AS (
--  SELECT movie_id,title,actors,genres
--  FROM(
--  SELECT
--  1 AS movie_id,
--  'Avengers:Endgame' AS title,
--  ARRAY<STRUCT<actor STRING,character STRING>>
--  [
--  STRUCT('RobertDowneyJr.','TonyStark'),
--  STRUCT('ChrisEvans','SteveRogers')
--  ] AS actors, 
--  ARRAY<STRING>['Action','Adventure','Drama'] AS genres
--  UNION ALL
--  SELECT
--  2,
--  'Inception',
--  ARRAY<STRUCT<actor STRING,character STRING>>
--  [
--  STRUCT('LeonardoDiCaprio','Cobb'),
--  STRUCT('JosephGordon-Levitt','Arthur')
--  ],
--  ARRAY<STRING>['Action','Adventure','Sci-Fi']
--  UNION ALL
--  SELECT
--  3,
--  'TheDarkKnight',
--  ARRAY<STRUCT<actor STRING,character STRING>>[
--  STRUCT('ChristianBale','BruceWayne'),
--  STRUCT('HeathLedger','Joker')
--  ],
--  ARRAY<STRING>['Action','Crime','Drama']
-- ))
# 1. array_exercises 테이블에서 각 영화(title) 별로 장르(genres)를 UNNEST 해서 보여주세요
-- SELECT
--   title,
--   genre
-- FROM advanced.array_exercises
-- CROSS JOIN UNNEST(genres) AS genre

# 2. array_exercises 테이블에서 각 영화(title)별로 배우(actor)와 배역(character)을 보여주세요. 배우와 배역은 별도의 컬럼으로 나와야 합니다.
-- SELECT
--   title,
--   actor.actor,
--   actor.character
-- FROM advanced.array_exercises
-- CROSS JOIN UNNEST(actors) AS actor

# 3. array_exercises 테이블에서 각 영화(title)별로 배우(actor), 배역(character), 장르(genre)를 출력하세요. 한 Row에 배우, 배역, 장르가 모두 표시되어야 합니다
-- SELECT
--   title,
--   actor.actor,
--   actor.character,
--   genre
-- FROM advanced.array_exercises
-- CROSS JOIN UNNEST(actors) AS actor,
-- UNNEST(genres) AS genre

# 4. 앱 로그 데이터(app_logs)의 배열을 풀어주세요
-- SELECT
--   user_id,
--   event_date,
--   event_name,
--   user_pseudo_id,
--   event_param.key,
--   event_param.value.string_value,
--   event_param.value.int_value
-- FROM advanced.app_logs
-- CROSS JOIN UNNEST(event_params) AS event_param

# 1. orders 테이블에서 유저(user_id)별로 주문 금액(amount)의 합계를 PIVOT 해주세요. 날짜(order_date)를 행(Row)으로, user_id를 열(Column)으로 만들어아 합니다
-- SELECT
--   order_date,
--   MAX(IF(user_id = 1, amount, 0)) AS user_1,
--   MAX(IF(user_id = 2, amount, 0)) AS user_2,
--   MAX(IF(user_id = 3, amount, 0)) AS user_3
-- FROM advanced.orders
-- GROUP BY
--   order_date
-- ORDER BY
--   order_date
-- SELECT
--   order_date,
--   MAX(IF(user_id = 1, sum_of_amount, 0)) AS user_1,
--   MAX(IF(user_id = 2, sum_of_amount, 0)) AS user_2,
--   MAX(IF(user_id = 3, sum_of_amount, 0)) AS user_3
-- FROM (
--   SELECT
--     order_date,
--     user_id,
--     MAX(amount) AS sum_of_amount
--   FROM advanced.orders
--   GROUP BY
--     order_date,
--     user_id
-- )
-- GROUP BY
--   order_date
-- ORDER BY
--   order_date

# 2. orders 테이블에서 날짜(order_date)별로 유저들의 주문 금액(amount)의 합계를 PIVOT 해주세요. user_id를 행(Row)으로, order_date를 열(Column)으로 만들어야 합니다
-- SELECT
--   user_id,
--   SUM(IF(order_date = '2023-05-01', amount, 0)) AS `2023-05-01`,
--   SUM(IF(order_date = '2023-05-02', amount, 0)) AS `2023-05-02`,
--   SUM(IF(order_date = '2023-05-03', amount, 0)) AS `2023-05-03`,
--   SUM(IF(order_date = '2023-05-04', amount, 0)) AS `2023-05-04`,
--   SUM(IF(order_date = '2023-05-05', amount, 0)) AS `2023-05-05`
-- FROM advanced.orders
-- GROUP BY
--   user_id
-- ORDER BY
--   user_id

# 3) orders 테이블에서 사용자(user_id)별, 날짜(order_date)별로 주문이 있다면 1, 없다면 0으로 PIVOT 해주세요. user_id를 행(Row)으로, order_date를 열(Column)로 만들고 주문을 많이 해도 1로 처리합니다
-- SELECT
--   user_id,
--   MAX(IF(order_date = '2023-05-01', amount, 0)) AS `2023-05-01`,
--   MAX(IF(order_date = '2023-05-02', amount, 0)) AS `2023-05-02`,
--   MAX(IF(order_date = '2023-05-03', amount, 0)) AS `2023-05-03`,
--   MAX(IF(order_date = '2023-05-04', amount, 0)) AS `2023-05-04`,
--   MAX(IF(order_date = '2023-05-05', amount, 0)) AS `2023-05-05`
-- FROM (
--   SELECT
--     user_id,
--     order_date,
--     CASE
--       WHEN amount IS NULL THEN 0
--       ELSE 1
--     END AS amount
--   FROM advanced.orders
-- )
-- GROUP BY
--   user_id
-- ORDER BY
--   user_id

-- WITH aug_first AS (
--   SELECT
--     *
--   FROM advanced.app_logs
--   WHERE
--     event_date = '2022-08-01'
-- )
-- SELECT
--   user_id,
--   event_date,
--   event_name,
--   user_pseudo_id,
--   IF(key = 'firebase_screen', string_value, NULL) AS firebase_screen,
--   IF(key = 'food_id', int_value, NULL) AS food_id,
--   IF(key = 'session_id', string_value, NULL) AS session_id
-- FROM (
--   SELECT
--     user_id,
--     event_date,
--     event_name,
--     user_pseudo_id,
--     event_param.key,
--     event_param.value.string_value,
--     event_param.value.int_value
--   FROM aug_first
--   CROSS JOIN UNNEST(event_params) AS event_param
--   WHERE
--     user_id = 32888 
-- )
-- WHERE
--   event_name LIKE('click%')

-- WITH sub AS (
-- SELECT
--   user_id,
--   event_date,
--   event_name,
--   event_timestamp,
--   user_pseudo_id,
--   event_param.key AS key,
--   event_param.value.string_value AS string_value,
--   event_param.value.int_value AS int_value
-- FROM (
--   SELECT
--     *
--   FROM advanced.app_logs
--   WHERE
--     event_date = '2022-08-01')
-- CROSS JOIN UNNEST(event_params) AS event_param
-- )

-- SELECT
--   event_date,
--   COUNT(user_id) AS user_cnt
-- FROM (
--   SELECT
--     user_id,
--     event_date,
--     event_name,
--     event_timestamp,
--     user_pseudo_id,
--     MAX(IF(sub.key = 'firebase_screen', sub.string_value, NULL)) AS firebase_screen,
--     MAX(IF(sub.key = 'food_id', sub.int_value, NULL)) AS food_id,
--     MAX(IF(sub.key = 'session_id', sub.string_value, NULL)) AS session_id
--   FROM sub
--   GROUP BY
--     user_id,
--     event_date,
--     event_name,
--     event_timestamp,
--     user_pseudo_id
-- )
-- WHERE
--   event_name = 'click_cart'
-- GROUP BY
--   event_date

# 퍼널 별 전환율
WITH base AS (
  SELECT
    event_date,
    event_timestamp,
    event_name,
    user_id,
    user_pseudo_id,
    platform,
    MAX(IF(event_param.key = 'firebase_screen', event_param.value.string_value, NULL)) AS firebase_screen,
    MAX(IF(event_param.key = 'session_id', event_param.value.string_value, NULL)) AS session_id
  FROM advanced.app_logs
  CROSS JOIN UNNEST(event_params) AS event_param
  WHERE
    event_date BETWEEN '2022-08-01' AND '2022-08-18'
  GROUP BY ALL
), filter_event_and_concat_event_and_screen AS (
  SELECT
    * EXCEPT(event_name, firebase_screen, event_timestamp),
    CONCAT(event_name,'-',firebase_screen) AS event_name_with_screen,
    DATETIME(TIMESTAMP_MICROS(event_timestamp), 'Asia/Seoul') AS event_datetime
  FROM base
  WHERE
    event_name IN ('screen_view', 'click_payment')
), before_pivot AS (
  SELECT
    event_date,
    event_name_with_screen,
    CASE
      WHEN event_name_with_screen = 'screen_view-welcome' THEN 1
      WHEN event_name_with_screen = 'screen_view-home' THEN 2
      WHEN event_name_with_screen = 'screen_view-food_category' THEN 3
      WHEN event_name_with_screen = 'screen_view-restaurant' THEN 4
      WHEN event_name_with_screen = 'screen_view-cart' THEN 5
      WHEN event_name_with_screen = 'click_payment-cart' THEN 6
      ELSE NULL
    END AS step_number,
    COUNT(DISTINCT user_pseudo_id) AS cnt
  FROM filter_event_and_concat_event_and_screen
  GROUP BY ALL
  HAVING
    step_number IS NOT NULL
  ORDER BY
    event_date
)

-- SELECT
--   event_date,
--   MAX(IF(step_number = 1, cnt, NULL)) AS `screen_view-welcome`,
--   MAX(IF(step_number = 2, cnt, NULL)) AS `screen_view-home`,
--   MAX(IF(step_number = 3, cnt, NULL)) AS `screen_view-food_category`,
--   MAX(IF(step_number = 4, cnt, NULL)) AS `screen_view-restaurant`,
--   MAX(IF(step_number = 5, cnt, NULL)) AS `screen_view-cart`,
--   MAX(IF(step_number = 6, cnt, NULL)) AS `click_payment-cart`,
--   CAST(MAX(IF(step_number = 2, cnt, NULL)) AS FLOAT64) / CAST(MAX(IF(step_number = 1, cnt, NULL)) AS FLOAT64) AS CVR1,
--   CAST(MAX(IF(step_number = 3, cnt, NULL)) AS FLOAT64) / CAST(MAX(IF(step_number = 2, cnt, NULL)) AS FLOAT64) AS CVR2,
--   CAST(MAX(IF(step_number = 4, cnt, NULL)) AS FLOAT64) / CAST(MAX(IF(step_number = 3, cnt, NULL)) AS FLOAT64) AS CVR3,
--   CAST(MAX(IF(step_number = 5, cnt, NULL)) AS FLOAT64) / CAST(MAX(IF(step_number = 4, cnt, NULL)) AS FLOAT64) AS CVR4,
--   CAST(MAX(IF(step_number = 6, cnt, NULL)) AS FLOAT64) / CAST(MAX(IF(step_number = 5, cnt, NULL)) AS FLOAT64) AS CVR5
-- FROM before_pivot
-- GROUP BY
--   event_date
-- ORDER BY
--   event_date

SELECT
  *
FROM before_pivot
