# 다음은 식품공장의 주문정보를 담은 FOOD_ORDER 테이블입니다. FOOD_ORDER 테이블은 다음과 같으며 ORDER_ID, PRODUCT_ID, AMOUNT, PRODUCE_DATE, IN_DATE,OUT_DATE,FACTORY_ID, WAREHOUSE_ID는 각각 주문 ID, 제품 ID, 주문양, 생산일자, 입고일자, 출고일자, 공장 ID, 창고 ID를 의미합니다.

# FOOD_ORDER 테이블에서 2022년 5월 1일을 기준으로 주문 ID, 제품 ID, 출고일자, 출고여부를 조회하는 SQL문을 작성해주세요. 출고여부는 2022년 5월 1일까지 출고완료로 이 후 날짜는 출고 대기로 미정이면 출고미정으로 출력해주시고, 결과는 주문 ID를 기준으로 오름차순 정렬해주세요.
# 쿼리를 작성하는 목표, 확인할 지표 : 2022/5/1일 까지 출고완료, 이후 출고 대기 NULL 출고 미정, 주문ID기준 오름차순/ OUT_DATE, ORDER_ID
# 쿼리 계산 방법 : CASE WHEN, ORDER BY
# 데이터의 기간 :
# 사용할 테이블 : FOOD_ORDER
# Join KEY :
# 데이터 특징 :

SELECT
    ORDER_ID,
    PRODUCT_ID,
    DATE_FORMAT(OUT_DATE, '%Y-%m-%d') AS OUT_DATE,
    CASE
        WHEN OUT_DATE <= '2022-05-01' THEN '출고완료'
        WHEN OUT_DATE > '2022-05-01' THEN '출고대기'
        WHEN OUT_DATE IS NULL THEN '출고미정'
    END AS 출고여부
FROM FOOD_ORDER
ORDER BY
    ORDER_ID ASC
    