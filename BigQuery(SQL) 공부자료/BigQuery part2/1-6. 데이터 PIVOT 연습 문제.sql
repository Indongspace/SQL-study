# 앱 로그 데이터 배열 PIVOT 하기
# PIVOT : 축을 중심으로 회전한다
# PIVOT이 필요한 이유
# 1) 성능(퍼포먼스) PYTHON은 ROW가 많을 경우 느려짐. 미리 데이터를 가공해서 ROW를 줄임(네트워크, 데이터 처리 비용의 효율성)
# 2) 사용이 쉬움
# 3) 데이터 시각화 도구에서 PIVOT한 형태를 지원
# PIVOT 쿼리
# MAX, IF, GROUP BY를 사용한 PIVOT
# PIVOT하면서 연산도 진행할 수 있음(SUM, COUNT 등)
# PIVOT할 때 모든 값이 같은 경우 MAX를 사용하거나 ANY_VALUE를 사용

# 1) order 테이블에서 유저(user_id)별로 주문 금액(amount)의 합계를 PIVOT해주세요.
# 날짜(order_date)를 행(Row)으로, user_id를 열(Column)으로 만들어야 합니다
# 기대하는 output의 형태
# order_date | user_1 | user_2 | user_3
# PIVOT : MAX(IF(조건, TRUE일 때의 값, FALSE일 때의 값)) AS new_column + GROUP BY
# version 1
-- SELECT
--   order_date,
--   SUM(IF(user_id = 1, amount, 0)) AS user_1,
--   SUM(IF(user_id = 2, amount, 0)) AS user_2,
--   SUM(IF(user_id = 3, amount, 0)) AS user_3
-- FROM advanced.orders
-- GROUP BY
--   order_date
-- ORDER BY
--   order_date ASC
# version 2
-- SELECT
--   order_date,
--   MAX(IF(user_id = 1, sum_of_amount, 0)) AS user_1,
--   MAX(IF(user_id = 2, sum_of_amount, 0)) AS user_2,
--   MAX(IF(user_id = 3, sum_of_amount, 0)) AS user_3,
-- FROM (
--   SELECT
--     order_date,
--     user_id,
--     MAX(amount) AS sum_of_amount
--   FROM advanced.orders
--   GROUP BY
--     order_date, user_id
-- )
-- GROUP BY
--   order_date
-- ORDER BY
--   order_date

# 첫번째 풀이는 PIVOT을 하면서 바로 SUM을 한 것
# 두번째 풀이는 집계 함수를 사용해서 집계한 후에 PIVOT(MAX)

# 2) orders 테이블에서 날짜(order_date)별로 유저들의 주문 금액(amount)의 합계를 PIVOT 해주세요.
# user_id를 행(Row)으로, order_date를 열(Column)으로 만들어야 합니다
# 기대하는 output의 형태
# user_id | 2023-05-01 | 2023-05-02 | 2023-05-03 | 2023-05-04 | 2023-05-05
-- SELECT
--   user_id,
--   SUM(IF(order_date = '2023-05-01', amount, 0)) AS `2023-05-01`,
--   SUM(IF(order_date = '2023-05-02', amount, 0)) AS `2023-05-02`,
--   SUM(IF(order_date = '2023-05-03', amount, 0)) AS `2023-05-03`,
--   SUM(IF(order_date = '2023-05-04', amount, 0)) AS `2023-05-04`,
--   SUM(IF(order_date = '2023-05-05', amount, 0)) AS `2023-05-05`
--   -- Syntax error: Unexpected integer literal "2023" at [57:52]
--   -- 컬럼의 이름을 지정할 때, 영어 제외하고 backtick(`)
--   -- ANY_VALUE : 그룹화 할 대상 중에 임의의 값을 선택한다(NULL을 제외하고). ANY_VALUE에선 나머지 값들이 NULL이거나 확정적으로 이 값이 나올 것이라 기대할 때 사용한다!
-- FROM advanced.orders
-- GROUP BY
--   user_id
-- ORDER BY 
--   user_id

# 3) orders 테이블에서 사용자(user_id)별, 날짜(order_date)별로 주문이 있다면 1, 없다면 0으로 PIVOT해주세요.
# user_id를 행(Row)으로, order_date를 열(Column)로 만들고 주문을 많이 해도 1로 처리합니다.
-- SELECT
--   user_id,
--   MAX(IF(order_date = '2023-05-01', 1, 0)) AS `2023-05-01`,
--   MAX(IF(order_date = '2023-05-02', 1, 0)) AS `2023-05-02`,
--   MAX(IF(order_date = '2023-05-03', 1, 0)) AS `2023-05-03`,
--   MAX(IF(order_date = '2023-05-04', 1, 0)) AS `2023-05-04`,
--   MAX(IF(order_date = '2023-05-05', 1, 0)) AS `2023-05-05`
-- FROM advanced.orders
-- GROUP BY
--   user_id

# 횟수를 구해달라고 할 경우엔 어떻게 해야할까?
-- SELECT
--   user_id,
--   SUM(IF(order_date = '2023-05-01', 1, 0)) AS `2023-05-01`,
--   SUM(IF(order_date = '2023-05-02', 1, 0)) AS `2023-05-02`,
--   SUM(IF(order_date = '2023-05-03', 1, 0)) AS `2023-05-03`,
--   SUM(IF(order_date = '2023-05-04', 1, 0)) AS `2023-05-04`,
--   SUM(IF(order_date = '2023-05-05', 1, 0)) AS `2023-05-05`
-- FROM advanced.orders
-- GROUP BY
--   user_id

# 데이터가 어떻게 생겼는지, 어떻게 저장되어 있는지 잘 보기


# 앱 로그 PIVOT
# user_id = 32888이 카트 추가하기(click_cart)를 누를 때 어떤 음식(food_id)을 담았나요?
# => key를 Column으로 두고, string_value나 int_value를 Column의 값으로 설정하는 것이 필요
# version 1
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
--   event_name = 'click_cart' AND food_id = 1544
-- GROUP BY
--   event_date

# version 2
WITH base AS (
  SELECT
  -- * EXCEPT(event_params), # * EXCEPT(컬럼) : 컬럼을 제외하고 모두 다 보여줘
    event_date,
    event_timestamp,
    event_name,
    user_id,
    user_pseudo_id,
    MAX(IF(param.key = 'firebase_screen', param.value.string_value, NULL)) AS firebase_screen,
    MAX(IF(param.key = 'food_id', param.value.int_value, NULL)) AS food_id,
    MAX(IF(param.key = 'session_id', param.value.string_value, NULL)) AS session_id,
  FROM advanced.app_logs
  CROSS JOIN UNNEST(event_params) AS param
  WHERE
    event_date = "2022-08-01"
  GROUP BY ALL
)

SELECT
  event_date,
  COUNT(user_id) AS user_cnt
FROM base
WHERE
  event_name = 'click_cart' # AND food_id = 1544
GROUP BY
  event_date

