# 각 분기(QUARTER)별 분화된 대장균의 개체의 총 수(ECOLI_COUNT)를 출력하는 SQL 문을 작성해주세요. 
# 이때 각 분기에는 'Q' 를 붙이고 분기에 대해 오름차순으로 정렬해주세요. 대장균 개체가 분화되지 않은 분기는 없습니다.
# 쿼리를 작성하는 목표, 확인할 지표 : 각 분기 별 ID = PARENT_ID 총 수, Q글자 붙이고 분기 오름차순
# 쿼리 계산 방법 : CASE WHEN, GROUP BY, COUNT, ORDER BY
# 데이터의 기간 :
# 사용할 테이블 : ECOLI_DATA
# Join KEY :
# 데이터 특징 :

SELECT
    CASE
        WHEN MONTH(DIFFERENTIATION_DATE) IN (1,2,3) THEN '1Q'
        WHEN MONTH(DIFFERENTIATION_DATE) IN (4,5,6) THEN '2Q'
        WHEN MONTH(DIFFERENTIATION_DATE) IN (7,8,9) THEN '3Q'
        WHEN MONTH(DIFFERENTIATION_DATE) IN (10,11,12) THEN '4Q'
        END AS QUARTER,
    COUNT(ID) AS ECOLI_COUNT
FROM ECOLI_DATA
GROUP BY
    QUARTER
ORDER BY
    QUARTER ASC
    