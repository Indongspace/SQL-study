# 쿼리를 작성하는 목표, 확인할 지표 : 두번째로 높은 연봉 출력 / salary
# 쿼리 계산 방법 : 1. salary 내림차순 -> 2. LIMIT 1 OFFSET -> 3. 1과 2의 결과를 CTE로 -> 4. CASE WHEN 으로 일치하는 수 가져오기 없으면 NULL 
# 데이터의 기간 : x
# 사용할 테이블 : employee
# JOIN KEY : x
# 데이터 특징 : x
SELECT
    salary
FROM employee