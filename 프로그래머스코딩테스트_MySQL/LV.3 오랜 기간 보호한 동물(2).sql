# ANIMAL_INS 테이블은 동물 보호소에 들어온 동물의 정보를 담은 테이블입니다. ANIMAL_INS 테이블 구조는 다음과 같으며, ANIMAL_ID, ANIMAL_TYPE, DATETIME, INTAKE_CONDITION, NAME, SEX_UPON_INTAKE는 각각 동물의 아이디, 생물 종, 보호 시작일, 보호 시작 시 상태, 이름, 성별 및 중성화 여부를 나타냅니다.

# ANIMAL_OUTS 테이블은 동물 보호소에서 입양 보낸 동물의 정보를 담은 테이블입니다. ANIMAL_OUTS 테이블 구조는 다음과 같으며, ANIMAL_ID, ANIMAL_TYPE, DATETIME, NAME, SEX_UPON_OUTCOME는 각각 동물의 아이디, 생물 종, 입양일, 이름, 성별 및 중성화 여부를 나타냅니다. ANIMAL_OUTS 테이블의 ANIMAL_ID는 ANIMAL_INS의 ANIMAL_ID의 외래 키입니다.

# 입양을 간 동물 중, 보호 기간이 가장 길었던 동물 두 마리의 아이디와 이름을 조회하는 SQL문을 작성해주세요. 
# 이때 결과는 보호 기간이 긴 순으로 조회해야 합니다.
# 쿼리를 작성하는 목표, 확인할 지표 : 입양을 간 동물 중(OUTS 테이블에 존재), 보호기간 긴 순으로 동물 두마리 정보/ ANIMAL_ID, DATETIME, NAME
# 쿼리 계산 방법 : WHERE INS IN OUTS, ORDER BY, LIMIT
# 데이터의 기간 :
# 사용할 테이블 : ANIMAL_INS, ANIMAL_OUTS
# Join KEY : ANIMAL_ID
# 데이터 특징 :

SELECT
    INS.ANIMAL_ID,
    INS.NAME
FROM ANIMAL_INS AS INS
INNER JOIN ANIMAL_OUTS AS OUTS
ON OUTS.ANIMAL_ID = INS.ANIMAL_ID
ORDER BY
    DATEDIFF(OUTS.DATETIME, INS.DATETIME) DESC
LIMIT 2