-- 데이터 생성 쿼리
CREATE OR REPLACE TABLE advanced.analytics_function_01 AS (
  SELECT 1004 AS user_id, 1 AS visit_month UNION ALL
  SELECT 1004, 3 UNION ALL
  SELECT 1004, 7 UNION ALL
  SELECT 1004, 8 UNION ALL
  SELECT 2112, 3 UNION ALL
  SELECT 2112, 6 UNION ALL
  SELECT 2112, 7 UNION ALL
  SELECT 3912, 4
)



-- 문제 1) user들의 다음 접속 월과 다다음 접속 월을 구하는 쿼리를 작성해주세요.
-- 윈도우 함수
-- 탐색 함수 : LEAD(이후), LAG(이전), FIRST_VALUE(첫 값), LAST_VALUE(마지막 값)
-- 함수(컬럼) OVER (PARTITION BY 파티션컬럼 ORDER BY 정렬할컬럼) AS 
-- LEAD, LAG -> 함수(컬럼, 순서). 순서를 명시하지 않으면 Default는 1

SELECT
  *,
  -- 다음 접속 월 => LEAD
  LEAD(visit_month) OVER (PARTITION BY user_id ORDER BY visit_month ASC) AS lead_visit_month,
  -- Window ORDER BY is required for analytic function lead at [10:26] : LEAD 함수는 항상 ORDER BY가 필요하다! => LEAD는 순서를 알아야 동작하는 함수이기 때문
  LEAD(visit_month, 2) OVER (PARTITION BY user_id ORDER BY visit_month ASC) AS lead2_visit_month
FROM advanced.analytics_function_01
ORDER BY user_id

-- 문제 2) user들의 다음 접속 월과 다다음 접속 월, 이전 접속 월을 구하는 쿼리를 작성해주세요.
SELECT
  *,
  LEAD(visit_month, 1) OVER (PARTITION BY user_id ORDER BY visit_month) AS after_visit_month,
  LEAD(visit_month, 2) OVER (PARTITION BY user_id ORDER BY visit_month) AS after2_visit_month,
  -- 이전 : LAG
  LAG(visit_month, 1) OVER (PARTITION BY user_id ORDER BY visit_month) AS before_visit_month
FROM advanced.analytics_function_01
ORDER BY user_id, visit_month
# LAG 함수를 사용할 때 NULL이 나온다 => 그 값은 처음이다!
# LEAD 함수를 사용할 때 NULL이 나온다 => 그 값은 마지막이다!

-- 3번 : 유저가 접속했을 때, 다음 접속까지의 간격을 구하시오
-- user_id | visit_month | after_visit_month | diff_month

SELECT
  *,
  after_visit_month - visit_month AS diff
FROM (
  SELECT
    *,
    LEAD(visit_month, 1) OVER (PARTITION BY user_id ORDER BY visit_month) AS after_visit_month
    -- after_visit_month - visit_month : 동작하지 않음
    -- Unrecognized name: after_visit_month at [34:3] : SELECT 절에 제일 마지막에 실행
    # 윈도우 함수를 이렇게 쓰는게 좋을까? => 중복된 쿼리는 줄이는 것이 좋을 수 있음
    -- 쿼리를 수정할 상황이 생김 => 2번 수정 => 굉장히 많아지면 복잡해지고, 실수하기 좋음
    -- 쿼리가 길어지는 것을 무서워하지 말고, 쿼리를 덜 수정할 수 있는 구조를 만들면 좋겠다!
    -- 윈도우 함수 쓰다보면 쿼리 줄이 길어짐. 감안하고 사용하면 좋겠다
  FROM advanced.analytics_function_01
)
ORDER BY user_id, visit_month

# 추가 문제 : 이 데이터셋을 기준으로 user_id의 첫번째 방문 월, 마지막 방문 월을 구하는 쿼리를 작성해주세요

