# 쿼리를 작성하는 목표, 확인할 지표 : 두번째로 높은 연봉 출력 / salary
# 쿼리 계산 방법 : 1. 조건문으로 max보다 작은 경우만 -> 2. 조건에 맞는 값 중에 max값(=2번째로 큰 값) -> 3. coalesce로 없으면 null
# 데이터의 기간 : x
# 사용할 테이블 : employee
# JOIN KEY : x
# 데이터 특징 : x
SELECT
    DISTINCT COALESCE(MAX(salary), NULL) AS secondhighestsalary
FROM employee
WHERE
    salary < (SELECT MAX(salary) FROM employee)
    