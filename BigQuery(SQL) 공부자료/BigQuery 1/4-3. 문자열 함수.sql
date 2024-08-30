-- 문자열 붙이기 ==> CONCAT
-- SELECT
--   CONCAT("안녕","하세요","!") AS result
-- CONCAT 인자로 STRING이나 숫자를 넣을 때는 데이터를 직접 넣어준 것 => FROM이 없어도 실행

-- 문자열 분리하기 => SPLIT
-- SELECT
--   SPLIT("가, 나, 다, 라",", ") AS result
-- SPLIT(문자열_원본, 나눌 기준이 되는 문자)  

-- 특정 단어 수정하기 => REPLACE
-- 치환하다
-- SELECT
--   REPLACE("안녕하세요","안녕","실천") AS result
-- REPLACE(문자열 원본, 찾을 단어, 바꿀 단어)

-- 문자열 자르기 => TRIM
-- 자르다
-- SELECT
--   TRIM("안녕하세요","하세요") AS result
-- TRIM(문자열 원본, 자를 단어)

-- SELECT
--   UPPER("abc") AS result
-- UPPER(문자열 원본)

-- SELECT
--   CONCAT("HI"," HELLO") AS concat_example,
--   SPLIT("1, 2, 3, 4",", ") AS split_example,
--   REPLACE("apple","ap","peo") AS replace_example,
--   TRIM("HELLO","LLO") AS trim_example,
--   UPPER("ab") AS upper_example









