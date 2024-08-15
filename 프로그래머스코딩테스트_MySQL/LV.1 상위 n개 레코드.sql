-- 동물 보호소에 가장 먼저 들어온 동물의 이름을 조회하는 SQL 문을 작성해주세요.
# 쿼리를 작성하는 목표, 확인할 지표 : 가장 먼저 들어온 동물의 이름 출력, datetime
# 쿼리 계산 방법 : order by datetime
# 데이터의 기간 :
# 사용할 테이블 : aac_intakes
# Join KEY :
# 데이터 특징 :

SELECT
	name
FROM for_coding_test.aac_intakes
ORDER BY
	datetime ASC
LIMIT 1

    