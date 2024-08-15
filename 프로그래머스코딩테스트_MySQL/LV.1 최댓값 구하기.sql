-- 가장 최근에 들어온 동물은 언제 들어왔는지 조회하는 SQL 문을 작성해주세요.
# 쿼리를 작성하는 목표, 확인할 지표 : 가장 최근에 들어온 동물
# 쿼리 계산 방법 : MAX / ORDER BY DESC LIMIT 1 
# 데이터의 기간 : 
# 사용할 테이블 : aac_intakes
# Join KEY : 
# 데이터의 특징

SELECT
    datetime 
FROM for_coding_test.aac_intakes
ORDER BY
	datetime DESC
LIMIT 1

-- SELECT
-- 	MAX(datetime)
-- FROM for_coding_test.aac_intakes
