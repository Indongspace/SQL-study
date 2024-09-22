# HR_DEPARTMENT 테이블은 회사의 부서 정보를 담은 테이블입니다. HR_DEPARTMENT 테이블의 구조는 다음과 같으며 DEPT_ID, DEPT_NAME_KR, DEPT_NAME_EN, LOCATION은 각각 부서 ID, 국문 부서명, 영문 부서명, 부서 위치를 의미합니다.

# HR_EMPLOYEES 테이블은 회사의 사원 정보를 담은 테이블입니다. HR_EMPLOYEES 테이블의 구조는 다음과 같으며 EMP_NO, EMP_NAME, DEPT_ID, POSITION, EMAIL, COMP_TEL, HIRE_DATE, SAL은 각각 사번, 성명, 부서 ID, 직책, 이메일, 전화번호, 입사일, 연봉을 의미합니다.

# 문제
# HR_DEPARTMENT와 HR_EMPLOYEES 테이블을 이용해 부서별 평균 연봉을 조회하려 합니다. 부서별로 부서 ID, 영문 부서명, 평균 연봉을 조회하는 SQL문을 작성해주세요.

# 평균연봉은 소수점 첫째 자리에서 반올림하고 컬럼명은 AVG_SAL로 해주세요.
# 결과는 부서별 평균 연봉을 기준으로 내림차순 정렬해주세요.

# 쿼리를 작성하는 목표, 확인할 지표 : 부서별 평균 연봉 조회 / SAL
# 쿼리 계산 방법 : LEFT JOIN, GROUP BY, AVG, ROUND, ORDER BY
# 데이터의 기간 :
# 사용할 테이블 : HR_DEPARTMENT, HR_EMPLOYEES
# Join KEY : DEPT_ID
# 데이터 특징 :

SELECT
    DEPT.DEPT_ID,
    DEPT.DEPT_NAME_EN,
    ROUND(AVG(SAL)) AS AVG_SAL
FROM HR_DEPARTMENT AS DEPT
INNER JOIN HR_EMPLOYEES AS EMP
ON DEPT.DEPT_ID = EMP.DEPT_ID
GROUP BY
    DEPT.DEPT_ID
ORDER BY
    AVG_SAL DESC
    