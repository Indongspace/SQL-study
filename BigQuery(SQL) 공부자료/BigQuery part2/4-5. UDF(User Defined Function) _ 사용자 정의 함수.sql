# SQL UDF 함수 만들기(Temp)
-- CREATE TEMP FUNCTION add_two_and_multiple_three(x INT64)
-- RETURNS INT64
-- AS (
--   (x + 2) * 3
-- );

-- SELECT
--   add_two_and_multiple_three(1) AS output1,
--   add_two_and_multiple_three(5) AS output2

# SQL UDF 함수 만들기(Persistent)
-- CREATE FUNCTION advanced.add_two_and_multiple_three(x INT64)
-- RETURNS INT64
-- AS (
--   (x + 2) * 3
-- ) OPTIONS (
--   description = '2를 더하고 3을 곱합니다'
-- )

-- SELECT
--   advanced.add_two_and_multiple_three(3) AS output

-- CREATE OR REPLACE FUNCTION advanced.os_change_kor(input STRING)
-- RETURNS STRING
-- AS (
--   CASE
--     WHEN input = 'iOS' THEN '아이폰'
--     WHEN input = 'Android' THEN '안드로이드'
--     ELSE input
--   END
-- );

-- SELECT
--   user_pseudo_id,
--   platform,
--   advanced.os_change_kor(platform) AS platform_kor
-- FROM advanced.app_logs
-- WHERE
--   event_date = '2022-08-01'

# UDF 관련 자료 - bqutil
-- SELECT
--   bqutil.fn.t_test([1.3, 2.2, 3.4], [2.0, 3.2, 4.5]) AS t_test_output

# UDF 관련 자료 - BigFunctions
WITH sample_data AS (
  SELECT json '{"created_at": "2022-01-01", "user": {"name": "James"}}' AS json_data
  UNION ALL
  SELECT json '{"user": {"friends": ["Jack", "Peter"]}}' AS json_data
)

SELECT
  bigfunctions.us.sql_to_flatten_json_column(json_data, 'sample_data.json_data')
FROM sample_data

