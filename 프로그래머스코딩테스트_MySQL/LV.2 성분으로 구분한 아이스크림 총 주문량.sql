# 상반기 동안 각 아이스크림 성분 타입과 성분 타입에 대한 아이스크림의 총주문량을 총주문량이 작은 순서대로 조회하는 SQL 문을 작성해주세요. 
# 이때 총주문량을 나타내는 컬럼명은 TOTAL_ORDER로 지정해주세요.
# 쿼리를 작성하는 목표, 확인할 지표 : 아이스크림 성분 타입에 대한 총주문량 / 총주문량이 작은 순서대로 조회
# 쿼리 계산 방법 : JOIN / GROUP BY / SUM / ORDER BY
# 데이터의 기간 :
# 사용할 테이블 : FIRST_HALF / ICECREAM_INFO
# Join KEY : FLAVOR
# 데이터 특징 :

SELECT
    INFO.INGREDIENT_TYPE,
    SUM(FIR.TOTAL_ORDER) AS TOTAL_ORDER
FROM FIRST_HALF AS FIR
LEFT JOIN ICECREAM_INFO AS INFO
ON FIR.FLAVOR = INFO.FLAVOR
GROUP BY
    INFO.INGREDIENT_TYPE 
ORDER BY
    TOTAL_ORDER ASC
    
