# 대장균들은 일정 주기로 분화하며, 분화를 시작한 개체를 부모 개체, 분화가 되어 나온 개체를 자식 개체라고 합니다.
# 다음은 실험실에서 배양한 대장균들의 정보를 담은 ECOLI_DATA 테이블입니다. ECOLI_DATA 테이블의 구조는 다음과 같으며, ID, PARENT_ID, SIZE_OF_COLONY, DIFFERENTIATION_DATE, GENOTYPE 은 각각 대장균 개체의 ID, 부모 개체의 ID, 개체의 크기, 분화되어 나온 날짜, 개체의 형질을 나타냅니다.
# 최초의 대장균 개체의 PARENT_ID 는 NULL 값입니다.

# 문제
# 3세대의 대장균의 ID(ID) 를 출력하는 SQL 문을 작성해주세요. 이때 결과는 대장균의 ID 에 대해 오름차순 정렬해주세요.

# 쿼리를 작성하는 목표, 확인할 지표 : 3세대 대장균의 ID 출력 / ID, PARENT_ID
# 쿼리 계산 방법 : 1. PARENT_ID IS NULL이 1세대 -> 2. 1세대 ID를 PARENT_ID로 갖고있는 대장균이 2세대 -> 3. 2세대 ID를 PARENT_ID로 갖고있는 대장균이 3세대 -> 3. ORDER BY
# 데이터의 기간 :
# 사용할 테이블 : ECOLI_DATA
# Join KEY : ID, PARENT_ID
# 데이터 특징 :
WITH GEN1 AS (
    SELECT
        ID,
        PARENT_ID
    FROM ECOLI_DATA
    WHERE
        PARENT_ID IS NULL
), GEN2 AS (
    SELECT
        BASE.ID,
        BASE.PARENT_ID
    FROM ECOLI_DATA AS BASE
    INNER JOIN GEN1
    ON BASE.PARENT_ID = GEN1.ID
)

SELECT
    BASE.ID
FROM ECOLI_DATA AS BASE
INNER JOIN GEN2
ON BASE.PARENT_ID = GEN2.ID
ORDER BY
    ID
    