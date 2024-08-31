DECLARE start_date DATE;
SET start_date = "2022-08-03";

SELECT
  event_date,
  COUNT(*) AS dau
FROM advanced.app_logs
WHERE
  event_date = start_date
GROUP BY ALL;


DECLARE i INT64 DEFAULT 1;
DECLARE sum_value INT64 DEFAULT 0;
DECLARE max_value INT64 DEFAULT 10;

WHILE i <= max_value DO
  IF MOD(i, 2) = 1 THEN
    SET sum_value = sum_value + i;
  END if;
  SET i = i + 1;
END WHILE;

SELECT
  i, 
  max_value,
  sum_value
  
-- EXECUTE IMMEDIATE
-- '''
-- SELECT 
--   @a * (@b + 2)
-- ''' 
-- USING 
--   1 AS a, 
--   2 AS b
-- # ?를 사용해서 변수를 넣고, 그 순서대로 주입할 수도 있음
-- # @변수이름을 사용하면 명시적으로 값을 주입할 수 있음

DECLARE custom_event STRING DEFAULT 'click_payment';
EXECUTE IMMEDIATE
'''
SELECT
  event_name,
  COUNT(*) AS output
FROM advanced.app_logs
WHERE event_date = "2022-08-01"
AND event_name = @custom_event_name
GROUP BY ALL 
'''
USING custom_event AS custom_event_name;

# MAX(IF(event_name = "", event_params.string, NULL))
