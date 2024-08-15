# FOOD_PRODUCT 테이블에서 가격이 제일 비싼 식품의 식품 ID, 식품 이름, 식품 코드, 식품분류, 식품 가격을 조회하는 SQL문을 작성해주세요.
# 쿼리를 작성하는 목표, 확인할 지표 : 가격이 제일 비싼 식품의 정보 조회
# 쿼리 계산 방법 : ORDER BY / LIMIT 1
# 데이터의 기간 :
# 사용할 테이블 : FOOD_PRODUCT
# Join KEY :
# 데이터 특징 :

SELECT
    PRODUCT_ID,
    PRODUCT_NAME,
    PRODUCT_CD,
    CATEGORY,
    PRICE 
FROM FOOD_PRODUCT
ORDER BY
    PRICE DESC
LIMIT 1

# 다른 답
SELECT
    PRODUCT_ID,
    PRODUCT_NAME,
    PRODUCT_CD,
    CATEGORY,
    PRICE 
FROM FOOD_PRODUCT
WHERE
    PRICE = (SELECT MAX(PRICE) FROM FOOD_PRODUCT)
