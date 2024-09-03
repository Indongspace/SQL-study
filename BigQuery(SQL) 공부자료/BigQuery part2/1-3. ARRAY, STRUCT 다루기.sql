-- 1) 대괄호 사용하기
-- SELECT [0,1,1,2,3,5] AS some_numbers
-- UNION ALL
-- SELECT [2,4,8,16,32]
-- UNION ALL
-- SELECT [5,10]

-- 2) ARRAY<> 사용하기 : ARRAY<자료형>
-- SELECT
-- ARRAY<INT64>[0,1,3] AS some_numbers

-- SELECT
-- ARRAY<INT64>[0,1,"가"] AS some_numbers --> Array element type STRING does not coerce to INT64 at [11:18]

-- 3) 배열 생성 함수 사용
-- SELECT
-- GENERATE_DATE_ARRAY('2024-01-01', '2024-02-01', INTERVAL 1 WEEK) AS output1,
-- GENERATE_ARRAY(1, 5, 2) AS output2

-- 4) ARRAY_AGG 함수 사용 : 여러 결과를 마지막에 배열로 저장하고 싶은 경우
-- WITH programming_languages AS (
--   SELECT "python" AS programming_language
--   UNION ALL
--   SELECT "go"
--   UNION ALL
--   SELECT "scala"
-- )

-- -- SELECT
-- --   *
-- -- FROM programming_languages

-- SELECT ARRAY_AGG(programming_language) AS output
-- FROM programming_languages

-- ARRAY(배열)의 데이터 접근하기
-- WITH array_samples AS (
--   SELECT [0,1,1,2,3,5] AS some_numbers
--   UNION ALL
--   SELECT [2,4,8,16,32]
--   UNION ALL
--   SELECT [5,10]
-- )

-- -- SELECT
-- --   some_numbers[SAFE_OFFSET(1)] AS first_value
-- -- FROM array_samples

-- SELECT
--   some_numbers[SAFE_OFFSET(5)] AS first_value
-- FROM array_samples

-- STRUCT(구조체) 생성하기
-- 1) 소괄호() 사용하기
-- SELECT
--   (1,2,3) AS struct_test
-- 소괄호 사용시 이름이 지정되어 있지 않음

-- 2) STRUCT<>() 사용하기 : STRUCT<자료형>(데이터)
-- SELECT
--   STRUCT<hi INT64, hello INT64, awesome STRING>(1, 2, 'HI') AS struct_test

-- STRUCT의 값에 접근하기
-- STRUCT의 이름.key
-- SELECT
--   struct_test.hi,
--   struct_test.hello,
--   struct_test.awesome
-- FROM ( 
--   SELECT
--     STRUCT<hi INT64, hello INT64, awesome STRING>(1,2,'HI') AS struct_test)

-- 예시 데이터 : 배열과 함께 존재하는 데이터
-- WITH example_data AS(
--  SELECT
--  'kyle'AS name,
--  ['Python','SQL','R','Julia','Go'] AS preferred_language,
--  'Incheon'AS hometown
--  UNION ALL
--  SELECT
--  'max'AS name,
--  ['Python','SQL','Scala','Java','Kotlin'] AS preferred_language,
--  'Seoul'AS hometown
--  UNION ALL
--  SELECT
--  'yun'AS name,
--  ['Python','SQL'] AS preferred_language,
--  'Incheon'AS hometown
--  )
--  SELECT
--  *
-- FROM example_data

-- UNNEST를 사용해 중첩된 데이터 구조 풀기(평면화, Flatten)
-- 배열을 직접적으로 접근해서 사용하는 것보다, 독립적인 행으로 풀어서(평면화) 사용
-- = ARRAY의 요소를 독립적인 행으로 펼칠때 UNNEST를 사용
-- 장바구니(배열)에 있는 과일(배열의 값)을 모두 다 꺼내는 것 : UNNEST
-- UNNEST 쿼리 문법
-- UNNEST한 결과를 CROSS JOIN
-- SELECT
--   a.column,
--   alias_name
-- FROM Table_A AS a
-- CROSS JOIN UNNEST(ARRAY_Column) AS alias_name
-- CROSS JOIN은 생략하고 쉼표를 사용해도 괜찮음 FROM Table_A AS a, UNNEST(ARRAY_Column) AS alias_name

-- UNNEST를 사용해 중첩된 데이터 구조 풀기(평면화, Flatten)
WITH example_data AS(
 SELECT
 'kyle'AS name,
 ['Python','SQL','R','Julia','Go'] AS preferred_language,
 'Incheon'AS hometown
 UNION ALL
 SELECT
 'max'AS name,
 ['Python','SQL','Scala','Java','Kotlin'] AS preferred_language,
 'Seoul'AS hometown
 UNION ALL
 SELECT
 'yun'AS name,
 ['Python','SQL'] AS preferred_language,
 'Incheon'AS hometown
 )

SELECT
  name,
  pref_lang,
  hometown
FROM example_data 
CROSS JOIN UNNEST(preferred_language) AS pref_lang



