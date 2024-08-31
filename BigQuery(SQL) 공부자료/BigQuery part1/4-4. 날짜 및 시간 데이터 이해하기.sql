-- SELECT
--   TIMESTAMP_MILLIS(1704176819711) AS milli_to_timestamp_value,
--   TIMESTAMP_MICROS(1704176819711000) AS micro_to_timestamp_value,
--   DATETIME(TIMESTAMP_MICROS(1704176819711000)) AS datetime_value,
--   DATETIME(TIMESTAMP_MICROS(1704176819711000), 'Asia/Seoul') AS datetime_value_asia;

-- SELECT
--   CURRENT_TIMESTAMP() AS timestamp_col,
--   DATETIME(CURRENT_TIMESTAMP(), 'Asia/Seoul') AS datetime_col

-- SELECT
--   CURRENT_DATE() AS current_date,
--   CURRENT_DATE('Asia/Seoul') AS asia_date,
--   CURRENT_DATETIME() AS current_datetime,
--   CURRENT_DATETIME("Asia/Seoul") AS currnet_datetime_asia;

-- SELECT
--   EXTRACT(DATE FROM DATETIME "2024-01-02 14:00:00") AS date,
--   EXTRACT(YEAR FROM DATETIME "2024-01-02 14:00:00") AS year,
--   EXTRACT(MONTH FROM DATETIME "2024-01-02 14:00:00") AS month,
--   EXTRACT(DAY FROM DATETIME "2024-01-02 14:00:00") AS day,
--   EXTRACT(HOUR FROM DATETIME "2024-01-02 14:00:00") AS hour,
--   EXTRACT(MINUTE FROM DATETIME "2024-01-02 14:00:00") AS minute

-- SELECT
--   EXTRACT(DAYOFWEEK FROM DATETIME "2024-01-21 14:00:00") AS day_of_week_sun,
--   EXTRACT(DAYOFWEEK FROM DATETIME "2024-01-22 14:00:00") AS day_of_week_mon,
--   EXTRACT(DAYOFWEEK FROM DATETIME "2024-01-23 14:00:00") AS day_of_week_tues,
--   EXTRACT(DAYOFWEEK FROM DATETIME "2024-01-27 14:00:00") AS day_of_week_satur;

-- SELECT
--   DATETIME "2024-03-02 14:42:13" AS original_data,
--   DATETIME_TRUNC(DATETIME "2024-03-02 14:42:13", DAY) AS day_trunc,
--   DATETIME_TRUNC(DATETIME "2024-03-02 14:42:13", YEAR) AS year_trunc,
--   DATETIME_TRUNC(DATETIME "2024-03-02 14:42:13", MONTH) AS month_trunc,
--   DATETIME_TRUNC(DATETIME "2024-03-02 14:42:13", HOUR) AS hour_trunc;

-- SELECT
--   PARSE_DATETIME('%Y-%m-%d %H:%M:%S', '2024-01-11 12:35:35') AS parse_datetime

-- SELECT
--   FORMAT_DATETIME("%c", DATETIME "2024-01-11 12:35:35") AS formatted

-- SELECT
--   LAST_DAY(DATETIME '2024-01-03 15:30:00') AS last_day,
--   LAST_DAY(DATETIME '2024-01-03 15:30:00', MONTH) AS last_day_month,
--   LAST_DAY(DATETIME '2024-01-03 15:30:00', WEEK) AS last_day_week,
--   LAST_DAY(DATETIME '2024-01-03 15:30:00',WEEK(SUNDAY)) AS last_day_week_sun,
--   LAST_DAY(DATETIME '2024-01-03 15:30:00', WEEK(MONDAY)) AS last_day_week_mon

SELECT
  DATETIME_DIFF(first_datetime, second_datetime, DAY) AS day_diff1, 
  DATETIME_DIFF(second_datetime, first_datetime, DAY) AS day_diff2,
  DATETIME_DIFF(first_datetime, second_datetime, MONTH) AS month_diff,
  DATETIME_DIFF(first_datetime, second_datetime, WEEK) AS week_diff
FROM (
  SELECT
    DATETIME "2024-04-02 10:20:00" AS first_datetime,
     DATETIME "2021-01-01 15:30:00"AS second_datetime
)







