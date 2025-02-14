WITH base AS (
  SELECT
    user_pseudo_id,
    event_timestamp_kst,
    LAG(event_timestamp_kst) OVER(PARTITION BY ga_session_id ORDER BY event_timestamp_kst ASC) AS prev_timestamp,
    event_name,
    ga_session_id
  FROM ga 
  WHERE
    user_pseudo_id = 'a8Xu9GO6TB'
), new_session AS (
  SELECT
    user_pseudo_id,
    event_timestamp_kst,
    event_name,
    ga_session_id,
    CASE
      WHEN prev_timestamp IS NULL OR (strftime('%s', event_timestamp_kst) - strftime('%s', prev_timestamp)) >= 600 THEN 1 ELSE 0
    END AS new_session_id 
  FROM base
)
SELECT
  user_pseudo_id,
  event_timestamp_kst,
  event_name,
  ga_session_id,
  SUM(new_session_id) OVER(PARTITION BY user_pseudo_id ORDER BY event_timestamp_kst ASC) AS new_session_id
FROM new_session
ORDER BY
  event_timestamp_kst
