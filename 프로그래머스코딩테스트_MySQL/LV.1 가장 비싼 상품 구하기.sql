-- PRODUCT 테이블에서 판매 중인 상품 중 가장 높은 판매가를 출력하는 SQL문을 작성해주세요. 
-- 이때 컬럼명은 MAX_PRICE로 지정해주세요.
# 쿼리를 작성하는 목표, 확인할 지표 : 가장 높은 판매가 / PRICE
# 쿼리 계산 방법 : MAX(PRICE)
# 데이터의 기간 :
# 사용할 테이블 : PRODUCT
# Join KEY :
# 데이터 특징 :

SELECT
    MAX(PRICE) AS MAX_PRICE
FROM PRODUCT