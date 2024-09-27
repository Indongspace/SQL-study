# CART_PRODUCTS 테이블은 장바구니에 담긴 상품 정보를 담은 테이블입니다. CART_PRODUCTS 테이블의 구조는 다음과 같으며, ID, CART_ID, NAME, PRICE는 각각 테이블의 아이디, 장바구니의 아이디, 상품 종류, 가격을 나타냅니다.

# 데이터 분석 팀에서는 우유(Milk)와 요거트(Yogurt)를 동시에 구입한 장바구니가 있는지 알아보려 합니다. 우유와 요거트를 동시에 구입한 장바구니의 아이디를 조회하는 SQL 문을 작성해주세요. 이때 결과는 장바구니의 아이디 순으로 나와야 합니다.

# 쿼리를 작성하는 목표, 확인할 지표 : MILK와 YOGURT를 동시에 구입한 장바구니의 아이디 / NAME
# 쿼리 계산 방법 : IN MILK WITH문과 IN YOGURT WITH문 교집합(INNER JOIN) -> DISTINCT -> ORDER BY 
# 데이터의 기간 :
# 사용할 테이블 : CART_PRODUCTS
# Join KEY : CART_ID
# 데이터 특징 :
WITH MILK_BUY AS (
    SELECT
        *    
    FROM CART_PRODUCTS
    WHERE NAME IN ('Milk')
), YOGURT_BUY AS (
    SELECT
        *    
    FROM CART_PRODUCTS
    WHERE NAME IN ('Yogurt')
)

SELECT
    DISTINCT MIL.CART_ID
FROM MILK_BUY AS MIL
INNER JOIN YOGURT_BUY AS YOG
ON MIL.CART_ID = YOG.CART_ID
ORDER BY
    MIL.CART_ID