# HR_DEPARTMENT, HR_EMPLOYEES, HR_GRADE 테이블에서 2022년도 한해 평가 점수가 가장 높은 사원 정보를 조회하려 합니다. 
# 2022년도 평가 점수가 가장 높은 사원들의 점수, 사번, 성명, 직책, 이메일을 조회하는 SQL문을 작성해주세요.
# 2022년도의 평가 점수는 상,하반기 점수의 합을 의미하고, 평가 점수를 나타내는 컬럼의 이름은 SCORE로 해주세요.
# 쿼리를 작성하는 목표, 확인할 지표 : 2022년도 평가 점수가 가장 높은 사원의 정보 / DEPT_ID, EMP_NO, GROUP BY YEAR, SCORE
# 쿼리 계산 방법 : JOIN, GROUP BY
# 데이터의 기간 :
# 사용할 테이블 : HR_DEPARTMENT, HR_EMPLOYEES, HR_GRADE
# Join KEY : DEPT_ID, EMP_NO
# 데이터 특징 :

SELECT
    SUM(GRADE.SCORE) AS SCORE,
    EMPLO.EMP_NO,
    EMPLO.EMP_NAME,
    EMPLO.POSITION,
    EMPLO.EMAIL
FROM HR_DEPARTMENT AS DEPART
LEFT JOIN HR_EMPLOYEES AS EMPLO
ON DEPART.DEPT_ID = EMPLO.DEPT_ID
LEFT JOIN HR_GRADE AS GRADE
ON EMPLO.EMP_NO = GRADE.EMP_NO
GROUP BY
    EMPLO.EMP_NO
ORDER BY
    SCORE DESC
LIMIT 1
