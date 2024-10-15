# 대장균들은 일정 주기로 분화하며, 분화를 시작한 개체를 부모 개체, 분화가 되어 나온 개체를 자식 개체라고 합니다.
# 다음은 실험실에서 배양한 대장균들의 정보를 담은 ECOLI_DATA 테이블입니다. ECOLI_DATA 테이블의 구조는 다음과 같으며, ID, PARENT_ID, SIZE_OF_COLONY, DIFFERENTIATION_DATE, GENOTYPE 은 각각 대장균 개체의 ID, 부모 개체의 ID, 개체의 크기, 분화되어 나온 날짜, 개체의 형질을 나타냅니다.
# 최초의 대장균 개체의 PARENT_ID 는 NULL 값입니다.

# 문제
# 각 세대별 자식이 없는 개체의 수(COUNT)와 세대(GENERATION)를 출력하는 SQL문을 작성해주세요. 이때 결과는 세대에 대해 오름차순 정렬해주세요. 단, 모든 세대에는 자식이 없는 개체가 적어도 1개체는 존재합니다.

# 쿼리를 작성하는 목표, 확인할 지표 : 각 세대 별 자식이 없는 개체의 수와 세대 출력 / ID, PARENT_ID
# 쿼리 계산 방법 : 1. 재귀 쿼리 REVURSIVE 사용 기본 단계 : WHERE PARENT_ID IS NULL로 1세대 추출, CASE WHEN으로 자식 유무 추가 -> 2. UNION ALL 재귀 단계 : CASE WHEN으로 자식 유무 추가, 재귀시 마다 세대에 1 추가 -> 3. 자식이 없는 대장균 정보만 추출 WHERE CHILD_O_X = 'X', 세대 별 GROUP BY -> 4. ORDER BY
# 데이터의 기간 :
# 사용할 테이블 : ECOLI_DATA 
# Join KEY :
# 데이터 특징 :

WITH RECURSIVE CTE AS (
    SELECT
        ID,
        PARENT_ID,
        # 자식 유무를 O, X로 표시하는 컬럼 추가
        CASE
            WHEN ID NOT IN (SELECT PARENT_ID FROM ECOLI_DATA WHERE PARENT_ID IS NOT NULL) THEN 'X'
            ELSE 'O'
        END AS CHILD_O_X,
        # 세대의 기존 값 = 1
        1 AS GENERATION 
    FROM ECOLI_DATA
    # 1세대 대장균 ID 추출하기 위한 조건문
    WHERE
        PARENT_ID IS NULL
    # 재귀를 위한 쿼리
    UNION ALL 
    SELECT
        ED.ID,
        ED.PARENT_ID,
        # 자식 유무를 O, X로 표시하는 컬럼 추가
        CASE
            WHEN ED.ID NOT IN (SELECT PARENT_ID FROM ECOLI_DATA WHERE PARENT_ID IS NOT NULL) THEN 'X'
            ELSE 'O'
        END AS CHILD_O_X,
        # 재귀시 마다 세대에 1 추가
        CTE.GENERATION + 1
    FROM ECOLI_DATA AS ED
    INNER JOIN CTE
    ON ED.PARENT_ID = CTE.ID
)

SELECT
    COUNT(ID) AS COUNT,
    GENERATION
FROM CTE
# 자식이 없는 대장균 정보만 추출
WHERE
    CHILD_O_X = 'X'
GROUP BY
    GENERATION
ORDER BY
    GENERATION