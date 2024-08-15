-- 동물 보호소에 들어온 모든 동물의 아이디와 이름을 ANIMAL_ID순으로 조회하는 SQL문을 작성해주세요.
# 쿼리를 작성하는 목표, 확인할 지표 : 모든 동물의 아이디와 이름, id 순으로 
# 쿼리 계산 방법 : order by animal_id
# 데이터의 기간 : 
# 확인할 테이블 : aac_intakes
# Join KEY :
# 데이터 특징

SELECT
	animal_id,
    name
FROM for_coding_test.aac_intakes
ORDER BY
	animal_id