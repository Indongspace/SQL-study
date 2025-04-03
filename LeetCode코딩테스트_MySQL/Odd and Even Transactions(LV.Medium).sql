# 쿼리를 작성하는 목표, 확인할 지표 : 홀수/짝수 별로 amount의 합산 구하기 / amount, transaction_date
# 쿼리 계산 방법 : 1. group by sum(case when)으로 홀수 짝수 별 amount의 sum 구하기 -> 2. 정렬
# 데이터의 기간 : x
# 사용할 테이블 : transactions
# JOIN KEY : x
# 데이터 특징 : x
SELECT
    transaction_date,
    # 1
    SUM(CASE WHEN amount % 2 != 0 THEN amount ELSE 0 END) AS odd_sum,
    SUM(CASE WHEN amount % 2 = 0 THEN amount ELSE 0 END) AS even_sum
FROM transactions
GROUP BY
    transaction_date
# 2
ORDER BY
    transaction_date
