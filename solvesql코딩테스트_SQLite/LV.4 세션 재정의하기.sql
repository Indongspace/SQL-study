WITH base AS (
  SELECT
    user_pseudo_id,
    ga_session_id,
    event_name,
    event_timestamp_kst,
    LAG(event_timestamp_kst) OVER(PARTITION BY user_pseudo_id ORDER BY event_timestamp_kst) AS prev_timestamp
  FROM ga 
  WHERE
    user_pseudo_id = 'S3WDQCqLpK'
), session_data AS (
  SELECT
    user_pseudo_id,
    ga_session_id,
    event_name,
    event_timestamp_kst,
    CASE
      WHEN prev_timestamp IS NULL OR (strftime('%s', event_timestamp_kst) - strftime('%s', prev_timestamp)) > 3600
      THEN 1 ELSE 0
    END AS new_session
  FROM base
)
SELECT
  user_pseudo_id,
  MIN(event_timestamp_kst) AS session_start,
  MAX(event_timestamp_kst) AS session_end
FROM (
  SELECT
    user_pseudo_id,
    event_timestamp_kst,
    SUM(new_session) OVER(PARTITION BY user_pseudo_id ORDER BY event_timestamp_kst ASC) AS session_id 
  FROM session_data
)
GROUP BY
  session_id
  