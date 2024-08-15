# PRODUCT 테이블에서 만원 단위의 가격대 별로 상품 개수를 출력하는 SQL 문을 작성해주세요. 
# 이때 컬럼명은 각각 컬럼명은 PRICE_GROUP, PRODUCTS로 지정해주시고 가격대 정보는 각 구간의 최소금액(10,000원 이상 ~ 20,000 미만인 구간인 경우 10,000)으로 표시해주세요. 
# 결과는 가격대를 기준으로 오름차순 정렬해주세요.
# 쿼리를 작성하는 목표, 확인할 지표 : 만원 단위 그룹 별로 상품의 개수
# 쿼리를 계산하는 방법 : WITH / TRUNCATE / GROUP BY / COUNT / ORDER BY
# 데이터의 기간 :
# 사용할 테이블 : PRODUCT
# Join KEY :
# 데이터 특징 :

WITH P AS (
    SELECT
        *,
        TRUNCATE(PRICE / 10000, 0) AS PG
    FROM PRODUCT
)

SELECT
    (P.PG*10000) AS PRICE_GROUP,
    COUNT(P.PRODUCT_ID) AS PRODUCTS
FROM P
GROUP BY
    PRICE_GROUP
ORDER BY
    PRICE_GROUP
    