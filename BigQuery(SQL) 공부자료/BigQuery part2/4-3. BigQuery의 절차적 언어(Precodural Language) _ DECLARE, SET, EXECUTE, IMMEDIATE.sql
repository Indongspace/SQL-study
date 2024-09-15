# DECLARE, SET
-- DECLARE start_date DATE;
-- SET start_date = '2022-08-03';

-- SELECT
--   event_date,
--   COUNT(*) AS dau
-- FROM advanced.app_logs
-- WHERE
--   event_date = start_date
-- GROUP BY ALL

# WHILE 반복문
# WHILE boolean_expression DO
#   sql_statement_list
# END WHILE;
-- DECLARE i INT64 DEFAULT 1;
-- DECLARE sum_value INT64 DEFAULT 0;
-- DECLARE max_value INT64 DEFAULT 10;

-- WHILE i <= max_value DO
--   IF MOD(i,2) = 1 THEN
--     SET sum_value = sum_value + i;
--   END IF;
--   SET i = i + 1;
-- END WHILE;

-- SELECT
--   CONCAT('The sum of odd numbers from 1 to ', SAFE_CAST(max_value AS STRING), ' is: ', SAFE_CAST(sum_value AS STRING)) AS result,
--   i,
--   sum_value,
--   max_value;

# EXECUTE IMMEDIATE
# EXECUTE IMMEDIATE
#   sql_expression [INTO variable] [USING identifier];
# sql_expression : 실행할 SQL 쿼리 구문. 문자열로 표현
# INTO 절 (선택) : 쿼리의 결과를 저장할 변수 지정
# USING 절 (선택) : 쿼리에 값을 전달할 변수 지정
# 문자열 사이에 ||을 사용해서 값을 연결할 수 있음
-- DECLARE table_name STRING DEFAULT 'advanced.app_logs';
-- EXECUTE IMMEDIATE 'SELECT * FROM ' || table_name || ' WHERE event_date = "2022-08-01" LIMIT 10';
-- SELECT * FROM advanced.app_logs WHERE event_date = '2022-08-01' LIMIT 10
# 여러 줄을 쓰고 싶은 경우 ''' 사용
# @파라미터로 이름 지정
# USING을 사용해서 값 주입
DECLARE custom_event STRING DEFAULT 'click_payment';
EXECUTE IMMEDIATE
'''
SELECT
  event_name,
  COUNT(*) AS output
FROM advanced.app_logs
WHERE event_date = '2022-08-01'
AND event_name = @custom_event_name
GROUP BY ALL
'''
USING custom_event AS custom_event_name;

-- EXECUTE IMMEDIATE
-- '''
-- SELECT
--   --? * (? + 2)
--   @a * (@b + 2)
-- '''
-- --USING 1, 3
-- # ?를 사용해서 변수를 넣고, 그 순서대로 주입할 수도 있음
-- USING 
--   1 AS a,
--   2 AS b
-- # @변수이름을 사용하면 명시적으로 값을 주입할 수 있음

# MAX(IF(event_name = '', event_params.string, NULL)) 문 같은, PIVOT 할 때, EXECUTE IMMEDIATE에 활용시킬 수 있다






