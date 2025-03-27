# 쿼리를 작성하는 목표, 확인할 지표 : 범위에 맞게 salary의 카테고리 부여 / income
# 쿼리 계산 방법 : 1. if 문으로 조건에 따라 category부여 -> 2. null일 경우 0 -> 3. union all로 병합
# 데이터의 기간 : x
# 사용할 테이블 : accounts
# JOIN KEY : x
# 데이터 특징 : x
SELECT
    'Low Salary' AS category,
    # 1 & 2
    COALESCE(COUNT(IF(income < 20000, 1, NULL)), 0) AS accounts_count
FROM accounts
# 3
UNION ALL
SELECT
    'Average Salary' AS category,
    # 1 & 2
    COALESCE(COUNT(IF(income BETWEEN 20000 AND 50000, 1, NULL)), 0) AS accounts_count
FROM accounts
# 3
UNION ALL
SELECT
    'High Salary' AS category,
    # 1 & 2
    COALESCE(COUNT(IF(income > 50000, 1, NULL)), 0) AS accounts_count
FROM accounts
