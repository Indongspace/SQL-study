
WITH base AS (
  SELECT
    DISTINCT
      user_id,
      user_pseudo_id,
      event_name,
      DATE(DATETIME(TIMESTAMP_MICROS(event_timestamp), 'Asia/Seoul')) AS event_date,
      DATETIME(TIMESTAMP_MICROS(event_timestamp), 'Asia/Seoul') AS event_datetime
  FROM advanced.app_logs
  WHERE
    event_date BETWEEN "2022-08-01" AND "2023-08-03"
), first_week_and_diff AS (
  SELECT
    *,
    DATE_DIFF(event_week, first_week, WEEK) AS weeks_after_first_week
  FROM (
    SELECT
      DISTINCT 
        user_pseudo_id,
        DATE_TRUNC(MIN(event_date) OVER(PARTITION BY user_pseudo_id), WEEK(MONDAY)) AS first_week,
        DATE_TRUNC(event_date, WEEK(MONDAY)) AS event_week
    FROM base
  )
), user_counts AS (
  SELECT
    first_week,
    weeks_after_first_week,
    COUNT(DISTINCT user_pseudo_id) AS active_users
  FROM first_week_and_diff
  GROUP BY 
    first_week,
    weeks_after_first_week
)


SELECT
  *,
  ROUND(SAFE_DIVIDE(active_users, cohort_users), 2) AS retention_rate
FROM (
  SELECT
    first_week,
    weeks_after_first_week,
    active_users,
    FIRST_VALUE(active_users) OVER(PARTITION BY first_week ORDER BY weeks_after_first_week ASC) AS cohort_users
  FROM user_counts
)
ORDER BY first_week, weeks_after_first_week