# 쿼리를 작성하는 목표, 확인할 지표 : 상품 별로 판매된 첫 해의 정보 출력 / product_id, year
# 쿼리 계산 방법 : 1. group by min으로 상품 별 첫 해의 정보 가져오기 -> 2. cte를 조건문에 사용해 상품별 첫해 정보 추출 
# 데이터의 기간 : x 
# 사용할 테이블 : sales
# JOIN KEY : x
# 데이터 특징 : x
WITH first_year AS (
    SELECT
        product_id,
        MIN(year) AS first_year
    FROM sales
    GROUP BY
        product_id
)
SELECT
    product_id,
    year AS first_year,
    quantity,
    price
FROM sales
WHERE
    (product_id, year) IN (SELECT product_id, first_year FROM first_year)
