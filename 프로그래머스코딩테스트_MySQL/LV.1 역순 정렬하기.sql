-- 문제 설명
-- ANIMAL_INS 테이블은 동물 보호소에 들어온 동물의 정보를 담은 테이블입니다. 
-- ANIMAL_INS 테이블 구조는 다음과 같으며, ANIMAL_ID, ANIMAL_TYPE, DATETIME, INTAKE_CONDITION, NAME, SEX_UPON_INTAKE는 
-- 							 각각 동물의 아이디, 생물 종, 보호 시작일, 보호 시작 시 상태, 이름, 성별 및 중성화 여부를 나타냅니다.
-- 동물 보호소에 들어온 모든 동물의 이름과 보호 시작일을 조회하는 SQL문을 작성해주세요. 
-- 이때 결과는 ANIMAL_ID 역순으로 보여주세요. 
# 쿼리를 작성하는 목표, 확인할 지표 : 동물의 이름과 보호 시작일 / name, datetime / id 역순
# 쿼리 계산 방법 : 
# 데이터의 기간 :
# 사용할 테이블 : aac_intakes
# Join KEY :
# 데이터 특징 :

SELECT
	name,
    datetime
FROM for_coding_test.aac_intakes
ORDER BY
	animal_id DESC