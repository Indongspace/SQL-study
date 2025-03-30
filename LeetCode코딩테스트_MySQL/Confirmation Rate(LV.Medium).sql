# 쿼리를 작성하는 목표, 확인할 지표 : 유저 별로 confirmed의 비율 구하기 / action
# 쿼리 계산 방법 : 1. signup 테이블을 기준으로 join -> 2. 유저별로 total과 confirmed 수 구하기(action 기록이 아예 없거나 confirmed가 없으면 0으로 표시되어야 함) -> 3. confirmed 비율 계산 -> 4. NULL 이면 0
# 데이터의 기간 : x
# 사용할 테이블 : signups, confirmations
# JOIN KEY : user_id
# 데이터 특징 : x
# 1
WITH base AS (
    SELECT
        s.user_id,
        c.action
    FROM signups AS s
    LEFT JOIN confirmations AS c
    ON s.user_id = c.user_id
)
SELECT
    # 3 & 4
    DISTINCT 
        user_id,
        COALESCE(ROUND(confirmed_cnt / total_cnt, 2), 0) AS confirmation_rate
FROM (
    # 2
    SELECT
        user_id,
        SUM(CASE WHEN action IS NOT NULL THEN 1 ELSE 0 END) OVER(PARTITION BY user_id) AS total_cnt,
        SUM(CASE WHEN action = 'confirmed' THEN 1 ELSE 0 END) OVER(PARTITION BY user_id) AS confirmed_cnt
    FROM base
) AS a
