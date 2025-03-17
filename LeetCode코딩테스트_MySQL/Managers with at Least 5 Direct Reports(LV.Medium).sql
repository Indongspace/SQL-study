# 쿼리를 작성하는 목표, 확인할 지표 : 5개 이상의 직접적인 보고를 받는 매니저의 이름 출력 / managerid, name
# 쿼리 계산 방법 : 1. managerid에 5번 이상 등장하는 id추출 -> 2. 조건문으로 그 id를 가진 name 추출 
# 데이터의 기간 : x
# 사용할 테이블 : employee
# JOIN KEY : manager_id, id
# 데이터 특징 : x
SELECT
    name
FROM employee
# 2
WHERE
    id IN 
 ( # 1
    SELECT
        managerid
    FROM employee
    GROUP BY
        managerid
    HAVING
        COUNT(*) >= 5)
