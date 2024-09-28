# 다음은 식품의 정보를 담은 FOOD_PRODUCT 테이블입니다. FOOD_PRODUCT 테이블은 다음과 같으며 PRODUCT_ID, PRODUCT_NAME, PRODUCT_CD, CATEGORY, PRICE는 식품 ID, 식품 이름, 식품코드, 식품분류, 식품 가격을 의미합니다.

# FOOD_PRODUCT 테이블에서 식품분류별로 가격이 제일 비싼 식품의 분류, 가격, 이름을 조회하는 SQL문을 작성해주세요. 이때 식품분류가 '과자', '국', '김치', '식용유'인 경우만 출력시켜 주시고 결과는 식품 가격을 기준으로 내림차순 정렬해주세요.

# 쿼리를 작성하는 목표, 확인할 지표 : 과자,국,김치,식용유 의 가장 비싼 상품 정보 출력 / PRICE, CATEGORY
# 쿼리 계산 방법 : WHERE IN으로 과자,국,김치,식용유만 추출 -> 윈도우 함수로 카테고리별 가장 비싼 상품 추출 -> JOIN으로 가장 비싼 상품의 정보 출력
# 데이터의 기간 :
# 사용할 테이블 : FOOD_PRODUCT
# Join KEY :
# 데이터 특징 :
WITH BASE AS (
    SELECT
        *    
    FROM FOOD_PRODUCT
    WHERE
        CATEGORY IN ('과자','국','김치','식용유')
), MAX_PRICE AS (
    SELECT
        *,
        MAX(PRICE) OVER(PARTITION BY CATEGORY ORDER BY PRICE DESC) AS MAX_PRICE
    FROM BASE
)

SELECT
    CATEGORY,
    MAX_PRICE,
    PRODUCT_NAME
FROM MAX_PRICE
WHERE
    PRICE = MAX_PRICE
ORDER BY
    MAX_PRICE DESC
    