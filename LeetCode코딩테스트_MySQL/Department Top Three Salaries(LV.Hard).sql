# 쿼리를 작성하는 목표, 확인할 지표 : 각 부서에서 탑 3의 연봉값을 가지고 있는 직원 추출 / salary
# 쿼리 계산 방법 : 1. 부서별 연봉(distinct) 탑 3 추출 -> 2. 탑3와 같은 연봉을 가지고 있는 직원 추출 -> 3. join으로 부서명 붙이기 
# 데이터의 기간 : x
# 사용할 테이블 : employee, department
# JOIN KEY : departmentid, id
# 데이터 특징 : x
WITH top_3 AS (
    SELECT
        departmentid,
        salary
    FROM (
        SELECT
            departmentid,
            salary,
            DENSE_RANK() OVER(PARTITION BY departmentid ORDER BY salary DESC) AS rnk
        FROM employee
    ) AS a
    WHERE
        rnk IN (1,2,3)
), base AS (
    SELECT
        DISTINCT
            e.name,
            e.salary,
            e.departmentid
    FROM employee AS e
    INNER JOIN  top_3 AS t
    ON e.salary = t.salary AND e.departmentid = t.departmentid
)
SELECT
    d.name AS department,
    b.name AS employee,
    b.salary AS salary
FROM base AS b
INNER JOIN department AS d
ON b.departmentid = d.id