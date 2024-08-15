-- 상반기 아이스크림 총주문량이 3,000보다 높으면서 
-- 아이스크림의 주 성분이 과일인 아이스크림의 맛을 
-- 총주문량이 큰 순서대로 조회하는 SQL 문을 작성해주세요.
# 쿼리를 작성하는 목표, 확인할 지표 : 주문량 3000보다 큼 / 주 성분이 과일 / 주문량 큰 순서대로
# 쿼리 계산 방법 : WHERE TOTAL_ORDER > 3000 / INGREDIENT_TYPE = fruit_based / ORDER BY TOTAL_ORDER DESC
# 데이터의 기간 :
# 사용할 테이블 : FIRST_HALF / ICECREAM_INFO
# Join KEY : FLAVOR
# 데이터의 특징 :

SELECT
    F.FLAVOR
FROM FIRST_HALF AS F
LEFT JOIN ICECREAM_INFO AS I
ON F.FLAVOR = I.FLAVOR
WHERE
    F.TOTAL_ORDER > 3000 AND
    I.INGREDIENT_TYPE = 'fruit_based'
ORDER BY
    F.TOTAL_ORDER DESC
    