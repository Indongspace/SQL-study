# ANIMAL_INS 테이블은 동물 보호소에 들어온 동물의 정보를 담은 테이블입니다. ANIMAL_INS 테이블 구조는 다음과 같으며, ANIMAL_ID, ANIMAL_TYPE, DATETIME, INTAKE_CONDITION, NAME, SEX_UPON_INTAKE는 각각 동물의 아이디, 생물 종, 보호 시작일, 보호 시작 시 상태, 이름, 성별 및 중성화 여부를 나타냅니다.

# ANIMAL_OUTS 테이블은 동물 보호소에서 입양 보낸 동물의 정보를 담은 테이블입니다. ANIMAL_OUTS 테이블 구조는 다음과 같으며, ANIMAL_ID, ANIMAL_TYPE, DATETIME, NAME, SEX_UPON_OUTCOME는 각각 동물의 아이디, 생물 종, 입양일, 이름, 성별 및 중성화 여부를 나타냅니다. ANIMAL_OUTS 테이블의 ANIMAL_ID는 ANIMAL_INS의 ANIMAL_ID의 외래 키입니다.

# 보호소에서 중성화 수술을 거친 동물 정보를 알아보려 합니다. 보호소에 들어올 당시에는 중성화1되지 않았지만, 보호소를 나갈 당시에는 중성화된 동물의 아이디와 생물 종, 이름을 조회하는 아이디 순으로 조회하는 SQL 문을 작성해주세요.

# 쿼리를 작성하는 목표, 확인할 지표 : ANIMAL_INS에는 중성화 X 표시 & ANIMAL_OUTS에는 중성화 표시 / SEX_UPON_INTAKE, SEX_UPON_OUTCOME
# 쿼리 계산 방법 : WITH 2개 생성, 1) SEX_UPON_INTAKE LIKE Intact%, 2) SEX_UPON_OUTCOME LIKE Spayed% OR Neutered% -> JOIN -> ORDER BY  
# 데이터의 기간 :
# 사용할 테이블 : ANIMAL_INS, ANIMAL_OUTS
# Join KEY : ANIMAL_ID
# 데이터 특징 :
WITH INTACT_ANIMAL AS (
    SELECT
        ANIMAL_ID,
        ANIMAL_TYPE,
        NAME
    FROM ANIMAL_INS
    WHERE
        SEX_UPON_INTAKE LIKE 'Intact%'
), SPAYED_OR_NEUTERED_ANIMAL AS (
    SELECT
        ANIMAL_ID,
        ANIMAL_TYPE,
        NAME
    FROM ANIMAL_OUTS
    WHERE
        SEX_UPON_OUTCOME LIKE 'Spayed%' OR
        SEX_UPON_OUTCOME LIKE 'Neutered%'
)   

SELECT
    INA.ANIMAL_ID,
    INA.ANIMAL_TYPE,
    INA.NAME
FROM INTACT_ANIMAL AS INA
INNER JOIN SPAYED_OR_NEUTERED_ANIMAL AS SON
ON INA.ANIMAL_ID = SON.ANIMAL_ID
ORDER BY
    INA.ANIMAL_ID
    