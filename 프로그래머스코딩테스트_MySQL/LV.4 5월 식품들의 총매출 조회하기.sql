# 다음은 식품의 정보를 담은 FOOD_PRODUCT 테이블과 식품의 주문 정보를 담은 FOOD_ORDER 테이블입니다. FOOD_PRODUCT 테이블은 다음과 같으며 PRODUCT_ID, PRODUCT_NAME, PRODUCT_CD, CATEGORY, PRICE는 식품 ID, 식품 이름, 식품코드, 식품분류, 식품 가격을 의미합니다.

# FOOD_ORDER 테이블은 다음과 같으며 ORDER_ID, PRODUCT_ID, AMOUNT, PRODUCE_DATE, IN_DATE, OUT_DATE, FACTORY_ID, WAREHOUSE_ID는 각각 주문 ID, 제품 ID, 주문량, 생산일자, 입고일자, 출고일자, 공장 ID, 창고 ID를 의미합니다.

# 문제
# FOOD_PRODUCT와 FOOD_ORDER 테이블에서 생산일자가 2022년 5월인 식품들의 식품 ID, 식품 이름, 총매출을 조회하는 SQL문을 작성해주세요. 이때 결과는 총매출을 기준으로 내림차순 정렬해주시고 총매출이 같다면 식품 ID를 기준으로 오름차순 정렬해주세요.

# 쿼리를 작성하는 목표, 확인할 지표 : 2022년 5월인 식품들 총 매출 추출   / PRODUCE_DATE, PRICE, AMOUNT
# 쿼리 계산 방법 : INNER JOIN -> WHERE 05월 -> PRICE * AMOUNT 총매출 -> WITH -> GROUP BY SUM -> ORDER BY
# 데이터의 기간 :
# 사용할 테이블 : FOOD_PRODUCT, FOOD_ORDER
# Join KEY : PRODUCT_ID
# 데이터 특징 :

WITH MAY AS (
    SELECT
        PRO.PRODUCT_ID,
        PRO.PRODUCT_NAME,
        PRO.PRICE * ORD.AMOUNT AS SALES
    FROM FOOD_PRODUCT AS PRO
    INNER JOIN FOOD_ORDER AS ORD
    ON PRO.PRODUCT_ID = ORD.PRODUCT_ID
    WHERE
        ORD.PRODUCE_DATE BETWEEN '2022-05-01' AND '2022-05-31'
)  

SELECT
    PRODUCT_ID,
    PRODUCT_NAME,
    SUM(SALES) AS TOTAL_SALES
FROM MAY
GROUP BY
    PRODUCT_ID
ORDER BY 
    TOTAL_SALES DESC,
    PRODUCT_ID ASC
    