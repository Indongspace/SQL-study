# 쿼리를 작성하는 목표, 확인할 지표 : 부서 별로 가장 높은 연봉을 가진 사람의 부서명과 이름 출력 / salary, departmentid, id
# 쿼리 계산 방법 : 1. join으로 부서이름 붙이기 -> 2. 부서별 최고연봉 구하기 -> 3. 부서별 최고연봉을 받는 사람의 정보(부서명,이름,연봉) 출력 
# 데이터의 기간 : x
# 사용할 테이블 : employee, department
# JOIN KEY : departmentid, id
# 데이터 특징 : x
SELECT
    d.name AS Department,
    e.name AS Employee,
    e.salary AS Salary
FROM employee AS e
# 1
INNER JOIN department AS d 
ON e.departmentid = d.id
# 2, 3
WHERE
    (e.departmentid,e.salary) IN (SELECT departmentid, MAX(salary) FROM employee GROUP BY departmentid)
