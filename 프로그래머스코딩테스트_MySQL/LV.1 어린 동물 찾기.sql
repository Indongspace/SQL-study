-- 동물 보호소에 들어온 동물 중 젊은 동물1의 아이디와 이름을 조회하는 SQL 문을 작성해주세요. 이때 결과는 아이디 순으로 조회해주세요.
# 쿼리를 작성하는 목표, 확인할 지표 : 젊은 동물의 아이디와 이름 
# 쿼리 계산 방법 : WHERE
# 데이터의 기간 :
# 사용할 테이블 : aac_intakes.intake_condition
# Join KEY :
# 데이터 특징 :

SELECT 
	animal_id,
    name
FROM for_coding_test.aac_intakes
WHERE 
	intake_condition != 'Aged'