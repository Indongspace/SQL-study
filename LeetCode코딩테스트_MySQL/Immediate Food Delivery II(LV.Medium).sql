# 쿼리를 작성하는 목표, 확인할 지표 : 첫주문 중에서 immediate(첫주문이 preffer_day)의 비율 / order_date, customer_pref_delivery_date 
# 쿼리 계산 방법 : 1. group by min을 사용해서 첫 주문과 첫 주문 했을 때의 pref_day 가져오기 -> 2. sum(pref_date와 같은 경우는 1 아니면 0) 으로 immediate가 몇 개인지 구하기 -> 3. immediate / first_order 로 비율 구하기 
# 데이터의 기간 : x
# 사용할 테이블 : delivery
# JOIN KEY : x
# 데이터 특징 : x
WITH base AS (
    SELECT 
        customer_id,
        MIN(order_date) AS first_order,
        MIN(customer_pref_delivery_date) AS preff_date
    FROM delivery
    GROUP BY
        customer_id
)
SELECT
    DISTINCT
        ROUND((immediate_cnt / total_cnt) * 100.0, 2) AS immediate_percentage
FROM (
SELECT
    COUNT(*) OVER() AS total_cnt,
    SUM(CASE WHEN first_order = preff_date THEN 1 ELSE 0 END) OVER() AS immediate_cnt,
    CASE WHEN first_order = preff_date THEN 1 ELSE 0 
    END AS t_f
FROM base
) AS a
