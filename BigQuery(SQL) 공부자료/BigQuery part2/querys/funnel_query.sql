-- 퍼널 데이터
-- 우리가 사용할 이벤트 => 단계
-- - screen_view : welcome, home, food_category, restaurant, cart
-- - click_payment
-- step_number : 추후에 정렬을 위해 만들 것
-- 사용할 데이터 : 앱 로그 데이터. GA/Firebase => UNNEST => PIVOT
-- 기간 : 2022-08-01 ~ 2022-08-18

WITH base AS (
  SELECT
    event_date,
    event_timestamp,
    event_name,
    user_id,
    user_pseudo_id,
    platform,
    -- event_param
    MAX(IF(event_param.key = "firebase_screen", event_param.value.string_value, NULL)) AS firebase_screen,
    -- MAX(IF(event_param.key = "food_id", event_param.value.int_value, NULL)) AS food_id,
    MAX(IF(event_param.key = "session_id", event_param.value.string_value, NULL)) AS session_id
  FROM advanced.app_logs
  CROSS JOIN UNNEST(event_params) AS event_param
  WHERE
    -- event_date = "2022-08-01" # 적은 데이터로 쿼리를 작성하기 위해 만들어둔 조건
    event_date BETWEEN "2022-08-01" AND "2022-08-18"
  GROUP BY ALL
), filter_event_and_concat_event_and_screen AS (
  -- (1) event_name + screen (필요한 이벤트만 WHERE 조건에 걸어서 사용)
  SELECT
    * EXCEPT(event_name, firebase_screen, event_timestamp),
    CONCAT(event_name, "-", firebase_screen) AS event_name_with_screen,
    DATETIME(TIMESTAMP_MICROS(event_timestamp), 'Asia/Seoul') AS event_datetime
  FROM base
  WHERE
    event_name IN ("screen_view", "click_payment")
)
-- (2) step_number + COUNT
-- step_number : CASE WHEN을 사용해 숫자 지정
# 일자 상관없이 퍼널의 유저 수를 집계한 쿼리 => 일자별로 하기 위해 event_date 추가
SELECT
  event_date, # 일자별로 퍼널별 유저 수 쿼리
  event_name_with_screen,
  CASE 
    WHEN event_name_with_screen = "screen_view-welcome" THEN 1
    WHEN event_name_with_screen = "screen_view-home" THEN 2
    WHEN event_name_with_screen = "screen_view-food_category" THEN 3
    WHEN event_name_with_screen = "screen_view-restaurant" THEN 4
    WHEN event_name_with_screen = "screen_view-cart" THEN 5
    WHEN event_name_with_screen = "click_payment-cart" THEN 6
  ELSE NULL
  END AS step_number,
  COUNT(DISTINCT user_pseudo_id) AS cnt
FROM filter_event_and_concat_event_and_screen
GROUP BY ALL
HAVING step_number IS NOT NULL
# WHERE : FROM 절에서 바로 필터링을 하고 싶은 컬럼
# HAVING : GROUP BY 후에 나오는 집계 결과에서 필터링을 하고 싶은 컬럼

-- WHERE
  -- user_pseudo_id = "1350836585.3421064109" : screen_view-welcome에 user_id는 NULL
-- ORDER BY event_timestamp
-- food_detail, search, search_result도 보면서 어떤 흐름으로 고객이 움직이는지 확인해보기!

-- 주석을 포함해서 코드를 공유드릴 예정인데, 그 이유는 제가 작성하는 맥락을 같이 보시면 좋겠음
-- 쿼리만 보면 이게 왜 이렇게 되었지? 알기 어려움 => 물어봐야 함. 과정을 모두 보여드리는 이유가 이렇게 다시 활용하기 위함

-- 다음 시간 : 스프레드시트를 사용해서 데이터 시각화
