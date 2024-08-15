# PRODUCT 테이블과 OFFLINE_SALE 테이블에서 상품코드 별 매출액(판매가 * 판매량) 합계를 출력하는 SQL문을 작성해주세요. 
# 결과는 매출액을 기준으로 내림차순 정렬해주시고 매출액이 같다면 상품코드를 기준으로 오름차순 정렬해주세요.
# 쿼리를 작성하는 목표, 확인할 지표 : 상품코드 별 매출액 합계를 출력 / 매출액 기준 내림차순 / 상품코드 기준 오름차순
# 쿼리 계산 방법 : JOIN / SUM / GROUP BY / ORDER BY 
# 데이터의 기간 :
# 사용할 테이블 : PRODUCT / OFFLINE_SALE
# Join KEY : PRODUCT_ID
# 데이터 특징 :

SELECT
    P.PRODUCT_CODE,
    SUM(P.PRICE * O.SALES_AMOUNT) AS SALES
FROM PRODUCT AS P
LEFT JOIN OFFLINE_SALE AS O
ON P.PRODUCT_ID = O.PRODUCT_ID
GROUP BY
    P.PRODUCT_CODE
ORDER BY
    SALES DESC,
    P.PRODUCT_CODE ASC
    