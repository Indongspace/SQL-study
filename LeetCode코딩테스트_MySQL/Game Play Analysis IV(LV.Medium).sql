# 쿼리를 작성하는 목표, 확인할 지표 : 전체 중에서 첫날과 둘째날 모두 접속 기록이 있는 사람 비율 구하기 / event_date, player_id
# 쿼리를 계산하는 방법 : 1. 전체 player 수 구하기 -> 2. 각 player 별 첫날 구하기 -> 3. 첫날과 둘째날 모두 접속한 사람의 수 구하기 -> 4. 비율 계산
# 데이터의 기간 : x
# 사용할 테이블 : activity
# JOIN KEY : x
# 데이터 특징 : x
WITH total_cnt AS (
    # 1
    SELECT
        COUNT(DISTINCT player_id) AS cnt
    FROM activity
), first_day AS (
    # 2
    SELECT
        player_id,
        MIN(event_date) AS first_day
    FROM activity
    GROUP BY
        player_id
), consecutive_cnt AS (
    # 3
    SELECT
        COUNT(*) AS consecutive_cnt
    FROM activity AS a
    INNER JOIN first_day AS f
    ON a.player_id = f.player_id
    WHERE
        f.first_day + INTERVAL 1 DAY = a.event_date
)
# 4
SELECT
    ROUND(consecutive_cnt / (SELECT cnt FROM total_cnt), 2) AS fraction
FROM consecutive_cnt
