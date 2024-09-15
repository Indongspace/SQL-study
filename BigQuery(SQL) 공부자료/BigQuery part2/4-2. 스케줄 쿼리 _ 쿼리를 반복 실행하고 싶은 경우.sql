SELECT
  event_date,
  COUNT(*) AS dau
FROM advanced.app_logs
# 스케줄 쿼리에서 실행 시점에 필터링하고 싶다면
# 쿼리에서 @run_time 또는 @run_date를 사용할 수 있음
# @run_time : 실행하기로 했던 시간(TIMESTAMP)
# @run_date : 실행하기로 했던 날의 날짜(DATE)
WHERE
  event_date = @run_date
GROUP BY ALL
ORDER BY
  event_date 
