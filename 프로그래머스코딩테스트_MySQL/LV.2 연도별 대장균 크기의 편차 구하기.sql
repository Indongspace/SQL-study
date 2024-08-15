# 분화된 연도(YEAR), 분화된 연도별 대장균 크기의 편차(YEAR_DEV), 대장균 개체의 ID(ID) 를 출력하는 SQL 문을 작성해주세요. 분화된 연도별 대장균 크기의 편차는 분화된 연도별 가장 큰 대장균의 크기 - 각 대장균의 크기로 구하며 
# 결과는 연도에 대해 오름차순으로 정렬하고 같은 연도에 대해서는 대장균 크기의 편차에 대해 오름차순으로 정렬해주세요.
# 쿼리를 작성하는 목표, 확인할 지표 : 연도별 가장 큰 대장균 크기 - 각 ID 대장균 크기, 출력, DIFFERENTIATION_DATE, SIZE_OF_COLONY 
# 쿼리 계산 방법 : WITH, GROUP BY, MAX - MIN, YEAR, ORDER BY
# 데이터의 기간 : 연도 별
# 사용할 테이블 : ECOLI_DATA
# Join KEY :
# 데이터 특징 :

WITH MAX_SIZE_OF_COLONY AS (
    SELECT
        YEAR(DIFFERENTIATION_DATE) AS YEAR,
        MAX(SIZE_OF_COLONY) AS MAX_SIZE
    FROM ECOLI_DATA
    GROUP BY
        YEAR(DIFFERENTIATION_DATE)
)

SELECT
    YEAR(DIFFERENTIATION_DATE) AS YEAR,
    MAX_DATA.MAX_SIZE - ECOLI_DATA.SIZE_OF_COLONY AS YEAR_DEV,
    ID
FROM ECOLI_DATA
LEFT JOIN MAX_SIZE_OF_COLONY AS MAX_DATA
ON MAX_DATA.YEAR = YEAR(ECOLI_DATA.DIFFERENTIATION_DATE)
ORDER BY
    YEAR ASC,
    YEAR_DEV ASC
    
