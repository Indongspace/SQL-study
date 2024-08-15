# PRODUCT 테이블에서 상품 카테고리 코드(PRODUCT_CODE 앞 2자리) 별 상품 개수를 출력하는 SQL문을 작성해주세요. 
# 결과는 상품 카테고리 코드를 기준으로 오름차순 정렬해주세요.
# 쿼리를 작성하는 목표, 확인할 지표 : 카테고리 코드 앞자리 2개 추출 / 상품 개수 출력 
# 쿼리 계산 방법 : SUBSTRING / GROUP BY / COUNT / ORDER BY
# 데이터의 기간 :
# 사용할 테이블 : PRODUCT
# Join KEY :
# 데이터 특징 :

SELECT
    SUBSTRING(PRODUCT_CODE, 1,2) AS CATEGORY,
    COUNT(PRODUCT_ID) AS PRODUCTS
FROM PRODUCT
GROUP BY
    SUBSTRING(PRODUCT_CODE, 1,2)
ORDER BY
    CATEGORY ASC
    