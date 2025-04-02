# 쿼리를 작성하는 목표, 확인할 지표 : free_trial에서 paid로 전환한 사람들의 free_trial / paid 별 평균 사용 시간 구하기 / activity_type, activity_date, activity_duration
# 쿼리 계산 방법 : 1. free_trial -> paid로 전환한 유저 구하기 -> 2. 이들 중에서 free_trial or paid 별 평균 사용 시간 구하기 -> 3. 정렬
# 데이터의 기간 : x
# 사용할 테이블 : useractivity
# JOIN KEY : x
# 데이터 특징 : x
WITH base AS (
    SELECT
        user_id,
        activity_type,
        activity_duration
    FROM useractivity
    # 1
    WHERE
        user_id IN (SELECT user_id FROM useractivity WHERE activity_type = 'free_trial') AND
        user_id IN (SELECT user_id FROM useractivity WHERE activity_type = 'paid')
), ft AS (
    # 2
    SELECT
        user_id,
        AVG(activity_duration) AS trial_avg_duration
    FROM base
    WHERE
        activity_type = 'free_trial'
    GROUP BY
        user_id
), p AS (
    # 2
    SELECT
        user_id,
        AVG(activity_duration) AS paid_avg_duration
    FROM base
    WHERE
        activity_type = 'paid'
    GROUP BY
        user_id
)
SELECT
    ft.user_id,
    ROUND(ft.trial_avg_duration, 2) AS trial_avg_duration,
    ROUND(p.paid_avg_duration, 2) AS paid_avg_duration
FROM ft
INNER JOIN p
ON ft.user_id = p.user_id
# 3
ORDER BY
    user_id 