# 쿼리를 작성하는 목표, 확인할 지표 : n번째 높은 연봉을 출력하는 함수 / salary
# 쿼리 계산 방법 : 1. 연봉 내림차순 -> 2. n - 1번째 행을 건너뛰고 다음 행 추출
# 데이터의 기간 : x
# 사용할 테이블 : employee
# JOIN KEY : x
# 데이터 특징 : x
CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
# 2 LIMIT과 OFFSET은 산술 연산을 읽지 못한다. 정수를 넣어야 한다.
SET N = N - 1;

  RETURN (
    SELECT
        DISTINCT salary
    FROM employee
    # 1
    ORDER BY
        salary DESC
    LIMIT 1
    # 2
    OFFSET N
  );

END