-- 1) orders 테이블에서 유저(user_id)별로 주문 금액(amount)의 합계를 PIVOT해주세요. 날짜(order_date)를 행(Row)으로, user_id를 열(Column)으로 만들어야 합니다

-- 기대하는 output의 형태
-- order_date | user_1 | user_2 | user_3
-- PIVOT : MAX(IF(조건, TRUE일 때의 값, FALSE일 때의 값)) AS new_colum + GROUP BY 
  -- MAX 대신 집계 함수를 사용할 수도 있음. SUM
-- FALSE일 때의 값은 NULL. 0도 사용할 수 있음
-- 첫번째 풀이
-- SELECT
--   order_date,
--   MAX(IF(user_id = 1, sum_of_amount, 0)) AS user_1,
--   MAX(IF(user_id = 2, sum_of_amount, 0)) AS user_2,
--   MAX(IF(user_id = 3, sum_of_amount, 0)) AS user_3  
-- FROM (
--   SELECT
--     order_date,
--     user_id,
--     # Amount의 합
--     SUM(amount) AS sum_of_amount
--   FROM advanced.orders
--   GROUP BY order_date, user_id
-- )
-- GROUP BY order_date
-- ORDER BY order_date

# 두번째 풀이

SELECT
  order_date,
  SUM(IF(user_id = 1, amount, 0)) AS user_1,
  SUM(IF(user_id = 2, amount, 0)) AS user_2,
  SUM(IF(user_id = 3, amount, 0)) AS user_3,
FROM advanced.orders
# command d(mac), ctrl d(window) => 같은 단어인 값을 여러개 선택할 수 있음
GROUP BY order_date
ORDER by order_date

# 첫번째 풀이는 집계 함수를 사용해서(SUM) 집계한 후에 PIVOT(MAX)
# 두번째 풀이는 PIVOT을 하면서 바로 SUM을 한 것
# 두가지 방법 다 올바른 풀이. 


-- 2) orders 테이블에서 날짜(order_date)별로 유저들의 주문 금액(amount)의 합계를 PIVOT 해주세요. user_id를 행(Row)으로, order_date를 열(Column)으로 만들어야 합니다
-- 기대하는 output의 형태
-- user_id | 2023-05-01 | 2023-05-02 | 2023-05-03 | 2023-05-04 | 2023-05-05 

SELECT
  user_id,
  -- ANY_VALUE(IF(order_date = "2023-05-01", amount, NULL)) AS `2023-05-01`,
  -- ANY_VALUE(IF(order_date = "2023-05-02", amount, NULL)) AS `2023-05-02`,
  -- ANY_VALUE(IF(order_date = "2023-05-03", amount, NULL)) AS `2023-05-03`,
  -- ANY_VALUE(IF(order_date = "2023-05-04", amount, NULL)) AS `2023-05-04`,
  -- ANY_VALUE(IF(order_date = "2023-05-05", amount, NULL)) AS `2023-05-05`,
  MAX(IF(order_date = "2023-05-01", amount, 0)) AS `2023-05-01`,
  MAX(IF(order_date = "2023-05-02", amount, 0)) AS `2023-05-02`,
  MAX(IF(order_date = "2023-05-03", amount, 0)) AS `2023-05-03`,
  MAX(IF(order_date = "2023-05-04", amount, 0)) AS `2023-05-04`,
  MAX(IF(order_date = "2023-05-05", amount, 0)) AS `2023-05-05`,
  -- Syntax error: Unexpected integer literal "2023" at [49:47]
  -- 컬럼의 이름을 지정할 때, 영어 제외하고 backtick(`) 
  -- ANY_VALUE : 그룹화 할 대상 중에 임의의 값을 선택한다 (NULL을 제외하고). ANY_VALUE에선 나머지 값들이 NULL이거나 확정적으로 이 값이 나올 것이다 기대할 때 사용한다! 
  -- MAX와 ANY_VALUE도 인지하고 있으면 좋음! 암기는 하지 않아도 괜찮음
FROM advanced.orders
GROUP BY user_id
ORDER BY user_id


-- 3) orders 테이블에서 사용자(user_id)별, 날짜(order_date)별로 주문이 있다면 1, 없다면 0으로 PIVOT 해주세요. user_id를 행(Row)으로, order_date를 열(Column)로 만들고 주문을 많이 해도 1로 처리합니다
-- # 정답
SELECT
  user_id, 
  # amount 대신 1이라고 표시. IF 문 안에 TRUE 일 때의 값이 항상 특정 컬럼이 아니라 1이라고 할 수도 있음(유무에 따라서)
  MAX(IF(order_date = '2023-05-01', 1, 0)) AS `2023-05-01`,
  MAX(IF(order_date = '2023-05-02', 1, 0)) AS `2023-05-02`,
  MAX(IF(order_date = '2023-05-03', 1, 0)) AS `2023-05-03`,
  MAX(IF(order_date = '2023-05-04', 1, 0)) AS `2023-05-04`,
  MAX(IF(order_date = '2023-05-05', 1, 0)) AS `2023-05-05`,
FROM advanced.orders
GROUP BY user_id

-- 횟수를 구해달라고 할 경우엔 어떻게 해야할까?
-- 지금 데이터에서는 MAX나 SUM이나 결과가 같다. 왜냐 데이터가 그렇기 때문
-- 데이터가 어떻게 생겼는지, 어떻게 저장되어 있는지
-- SELECT
--   user_id, 
--   SUM(IF(order_date = '2023-05-01', 1, 0)) AS `2023-05-01`,
--   SUM(IF(order_date = '2023-05-02', 1, 0)) AS `2023-05-02`,
--   SUM(IF(order_date = '2023-05-03', 1, 0)) AS `2023-05-03`,
--   SUM(IF(order_date = '2023-05-04', 1, 0)) AS `2023-05-04`,
--   SUM(IF(order_date = '2023-05-05', 1, 0)) AS `2023-05-05`,
-- FROM advanced.orders
-- GROUP BY user_id

# 앱 로그 PIVOT
WITH base AS (
  SELECT
    -- * EXCEPT(event_params), # * EXCEPT(컬럼) : 컬럼을 제외하고 모두 다 보여줘!
    event_date,
    event_timestamp,
    event_name,
    user_id,
    user_pseudo_id,
    MAX(IF(param.key = "firebase_screen", param.value.string_value, NULL)) AS firebase_screen,
    -- MAX(IF(param.key = "food_id", param.value.string_value, NULL)) AS food_id, # string_value엔 food_id 값들이 저장되어 있지 않음
    MAX(IF(param.key = "food_id", param.value.int_value, NULL)) AS food_id,
    MAX(IF(param.key = "session_id", param.value.string_value, NULL)) AS session_id
  FROM advanced.app_logs
  CROSS JOIN UNNEST(event_params) AS param
  WHERE event_date = "2022-08-01"
  GROUP BY ALL
)

# 예시
SELECT
  event_date,
  COUNT(user_id) AS user_cnt
FROM base
WHERE
  event_name = "click_cart" 
GROUP BY event_date




