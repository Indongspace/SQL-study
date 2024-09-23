# 대장균들은 일정 주기로 분화하며, 분화를 시작한 개체를 부모 개체, 분화가 되어 나온 개체를 자식 개체라고 합니다.
# 다음은 실험실에서 배양한 대장균들의 정보를 담은 ECOLI_DATA 테이블입니다. ECOLI_DATA 테이블의 구조는 다음과 같으며, ID, PARENT_ID, SIZE_OF_COLONY, DIFFERENTIATION_DATE, GENOTYPE 은 각각 대장균 개체의 ID, 부모 개체의 ID, 개체의 크기, 분화되어 나온 날짜, 개체의 형질을 나타냅니다.

# 문제
# 대장균 개체의 크기를 내름차순으로 정렬했을 때 상위 0% ~ 25% 를 'CRITICAL', 26% ~ 50% 를 'HIGH', 51% ~ 75% 를 'MEDIUM', 76% ~ 100% 를 'LOW' 라고 분류합니다. 대장균 개체의 ID(ID) 와 분류된 이름(COLONY_NAME)을 출력하는 SQL 문을 작성해주세요. 이때 결과는 개체의 ID 에 대해 오름차순 정렬해주세요 . 단, 총 데이터의 수는 4의 배수이며 같은 사이즈의 대장균 개체가 서로 다른 이름으로 분류되는 경우는 없습니다.

# 쿼리를 작성하는 목표, 확인할 지표 : 대장균 크기 % 별로 구분 / SIZE_OF_COLONY
# 쿼리 계산 방법 : SUM(SIZE_OF_COLONY) 한 결과에 -> SIZE_OF_COLONY 나누기 * 100 -> 순위 매겨서 COUNT(*)로 나누기 -> CASE WHEN
# 데이터의 기간 :
# 사용할 테이블 : ECOLI_DATA
# Join KEY : 
# 데이터 특징 :

# 1)
# WITH BASE AS (
#     SELECT
#         ID,
#         SIZE_OF_COLONY,
#         SUM(SIZE_OF_COLONY) OVER() AS TOTAL_SIZE,
#         (SIZE_OF_COLONY / SUM(SIZE_OF_COLONY) OVER()) * 100 AS POR
#     FROM ECOLI_DATA
# ), BASE2 AS 
# (  
#     SELECT
#         *,
#         RANK() OVER(ORDER BY POR DESC) AS ROWNUM,
#         COUNT(*) OVER() AS TOTAL_ROWNUM
#     FROM BASE
# )
# SELECT
#     ID,
#     CASE
#         WHEN (ROWNUM / TOTAL_ROWNUM) * 100 BETWEEN 0 AND 25 THEN 'CRITICAL'
#         WHEN (ROWNUM / TOTAL_ROWNUM) * 100 BETWEEN 26 AND 50 THEN 'HIGH'
#         WHEN (ROWNUM / TOTAL_ROWNUM) * 100 BETWEEN 51 AND 75 THEN 'MEDIUM'
#         WHEN (ROWNUM / TOTAL_ROWNUM) * 100 BETWEEN 76 AND 100 THEN 'LOW'
#     END AS COLONY_NAME
# FROM BASE2
# ORDER BY
#     ID ASC

# 2)
-- NTILE 함수는 SQL에서 데이터를 여러 개의 구간으로 나누고, 각 행이 해당 구간에 속하는 번호를 반환하는 윈도우 함수. 이 함수는 특히 데이터의 상대적인 위치를 기반으로 분포를 분석할 때 유용
-- = 데이터를 원하는 개수의 구간으로 나누어 각 행에 구간 번호를 할당하는 윈도우 함수. 데이터의 분포를 이해하고 분석하는데 도움을 줌 
SELECT
    ID,
    CASE
        WHEN RATIO = 1 THEN 'CRITICAL'
        WHEN RATIO = 2 THEN 'HIGH'
        WHEN RATIO = 3 THEN 'MEDIUM'
        WHEN RATIO = 4 THEN 'LOW'
    END AS COLONY_NAME
FROM (
SELECT
    ID,
    NTILE(4) OVER(ORDER BY SIZE_OF_COLONY DESC) AS RATIO
FROM ECOLI_DATA
) AS NTILE_RATIO
ORDER BY
    ID
    