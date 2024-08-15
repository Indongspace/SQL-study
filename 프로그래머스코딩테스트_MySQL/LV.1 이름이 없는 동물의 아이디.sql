-- 동물 보호소에 들어온 동물 중, 이름이 없는 채로 들어온 동물의 ID를 조회하는 SQL 문을 작성해주세요. 단, ID는 오름차순 정렬되어야 합니다.
# 쿼리를 작성하는 목표, 확인할 지표 : 이름이 없는 동물의 id, id는 오름차순
# 쿼리 계산 방법 : WHERE is null / ORDER BY
# 데이터의 기간 :  
# 사용할 테이블 : aac_intakes
# Join KEY :
# 데이터 특징 :

SELECT
	animal_id
FROM for_coding_test.aac_intakes
WHERE
	name IS NULL
ORDER BY
	animal_id
