# JSON 함수 예시
WITH sample AS (
  SELECT
    PARSE_JSON('{"name": "Jakob", "age": "6"}') AS json_data,
    JSON '{"fruits": ["apples", "oranges", "grapes"]}' AS json_array_data
)

-- SELECT
--   JSON_QUERY(json_data, '$.name') AS json_name,
--   JSON_VALUE(json_data, '$.name') AS scalar_name,
--   JSON_QUERY(json_data, '$.age') AS json_age,
--   JSON_VALUE(json_data, '$.age') AS scalar_age,
--   -- JSON_QUERY_ARRAY(json_data, '$.name') AS json_name_array,
--   -- JSON_VALUE_ARRAY(json_data, '$.name') AS scalar_name_array
--   JSON_QUERY_ARRAY(json_array_data, '$.fruits') AS json_name_array,
--   JSON_VALUE_ARRAY(json_array_data, '$.fruits') AS scalar_name_array
-- FROM sample

SELECT
  JSON_QUERY(json_array_data, '$.fruits') AS fruits_name,
  JSON_VALUE(json_array_data, '$.fruits') AS scalar_name,
  JSON_QUERY_ARRAY(json_array_data, '$.fruits') AS json_name_array,
  JSON_VALUE_ARRAY(json_array_data, '$.fruits') AS scalar_name_array
FROM sample
# scalar - 단일문자, 숫자

# JSON 핵심 함수
# JSON_QUERY - JSON 데이터에서 JSON 객체나 배열을 추출
# JSON_QUERY_ARRAY - JSON 배열에서 각 요소를 JSON 객체, 배열로 추출
# JSON_VALUE - JSON 데이터에서 단일 스칼라 값을 추출. 스칼라 값 : 데이터의 기본 단위로 더이상 나눌 수 없는 단일값(문자열,숫자,불리언)
# JSON_VALUE_ARRAY - JSON 배열에서 각 요소를 스칼라 값으로 추출


