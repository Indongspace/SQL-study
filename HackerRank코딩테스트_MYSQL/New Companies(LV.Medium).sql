-- Amber's conglomerate corporation just acquired some new companies. Each of the companies follows this hierarchy:
-- Founder -> Lead Manager -> Senior Manager -> Manager -> Employee
-- Given the table schemas below, write a query to print the company_code, founder name, total number of lead managers, total number of senior managers, total number of managers, and total number of employees. Order your output by ascending company_code.

-- Note:
-- The tables may contain duplicate records.
-- The company_code is string, so the sorting should not be numeric. For example, if the company_codes are C_1, C_2, and C_10, then the ascending company_codes will be C_1, C_10, and C_2.

-- Input Format
-- The following tables contain company data:
-- Company: The company_code is the code of the company and founder is the founder of the company.
-- Lead_Manager: The lead_manager_code is the code of the lead manager, and the company_code is the code of the working company.
-- Senior_Manager: The senior_manager_code is the code of the senior manager, the lead_manager_code is the code of its lead manager, and the company_code is the code of the working company.
-- Manager: The manager_code is the code of the manager, the senior_manager_code is the code of its senior manager, the lead_manager_code is the code of its lead manager, and the company_code is the code of the working company. 
-- Employee: The employee_code is the code of the employee, the manager_code is the code of its manager, the senior_manager_code is the code of its senior manager, the lead_manager_code is the code of its lead manager, and the company_code is the code of the working company.

-- Sample Output
-- C1 Monika 1 2 1 2
-- C2 Samantha 1 1 2 2

-- Explanation
-- In company C1, the only lead manager is LM1. There are two senior managers, SM1 and SM2, under LM1. There is one manager, M1, under senior manager SM1. There are two employees, E1 and E2, under manager M1.
-- In company C2, the only lead manager is LM2. There is one senior manager, SM3, under LM2. There are two managers, M2 and M3, under senior manager SM3. There is one employee, E3, under manager M2, and another employee, E4, under manager, M3.

-- Amber의 대기업이 최근 몇 개의 새로운 회사를 인수했습니다. 각 회사는 다음과 같은 계층 구조를 따릅니다:
-- 창립자(Founder) -> 수석 관리자(Lead Manager) -> 선임 관리자(Senior Manager) -> 관리자(Manager) -> 직원(Employee)
-- 아래의 테이블 스키마를 바탕으로, company_code, 창립자 이름, 수석 관리자 수, 선임 관리자 수, 관리자 수, 직원 수를 출력하는 쿼리를 작성하세요. 출력 결과는 company_code를 오름차순으로 정렬해야 합니다.

-- 주의 사항:
-- 테이블에는 중복 레코드가 포함될 수 있습니다.
-- company_code는 문자열이므로 정렬은 숫자가 아닌 사전식으로 이루어져야 합니다. 예를 들어, company_code가 C_1, C_2, C_10이라면 오름차순 정렬 결과는 C_1, C_10, C_2입니다.

-- 입력 형식
-- 다음 테이블들은 회사의 데이터를 포함하고 있습니다:
-- Company: company_code는 회사의 코드이고, founder는 회사의 창립자입니다.
-- Lead_Manager: lead_manager_code는 수석 관리자의 코드이며, company_code는 근무 중인 회사의 코드입니다.
-- Senior_Manager: senior_manager_code는 선임 관리자의 코드이고, lead_manager_code는 해당 선임 관리자가 속한 수석 관리자의 코드이며, company_code는 근무 중인 회사의 코드입니다.
-- Manager: manager_code는 관리자의 코드이고, senior_manager_code는 해당 관리자가 속한 선임 관리자의 코드이며, lead_manager_code는 해당 관리자가 속한 수석 관리자의 코드이고, company_code는 근무 중인 회사의 코드입니다.
-- Employee: employee_code는 직원의 코드이고, manager_code는 해당 직원이 속한 관리자의 코드이며, senior_manager_code는 해당 직원이 속한 선임 관리자의 코드이고, lead_manager_code는 해당 직원이 속한 수석 관리자의 코드이며, company_code는 근무 중인 회사의 코드입니다.

-- 출력 예시
-- C1 Monika 1 2 1 2
-- C2 Samantha 1 1 2 2

-- 설명
-- 회사 C1에서는 수석 관리자 LM1이 유일합니다. 선임 관리자는 LM1 아래에 SM1과 SM2 총 두 명이 있습니다. 관리자 M1은 선임 관리자 SM1 아래에 있습니다. 직원은 관리자 M1 아래에 E1과 E2 두 명이 있습니다.
-- 회사 C2에서는 수석 관리자 LM2가 유일합니다. 선임 관리자 SM3은 LM2 아래에 있습니다. 관리자는 SM3 아래에 M2와 M3 두 명이 있습니다. 직원은 관리자 M2 아래에 E3 한 명이 있고, 관리자 M3 아래에 E4 한 명이 있습니다.

# 쿼리를 작성하는 목표, 확인할 지표 : company_code,창립자이름,수석관리자수,선임관리자수,관리자수,직원수 출력 / COUNT(~~_code)
# 쿼리 계산 방법 :
# 1. founder -> 수석관리자 연결 ->
# 2. 수석관리자 -> 선임관리자 연결 ->
# 3. 선임관리자 -> 관리자 연결 ->
# 4. 관리자 -> 직원 연결 ->
# 5. 회사 별 창립자 별 그룹화 ->
# 6. DISTINCT, COUNT로 중복 제거한 행의 수 ->
# 7. 정렬
# 데이터의 기간 :
# 사용할 테이블 : company, lead_manager, senior_manager, manager, employee
# Join KEY : company_code, lead_manager_code, senior_manager_code, manager_code,
# 데이터 특징 :
SELECT
    fo.company_code,
    fo.founder,
    # 6. DISTINCT, COUNT로 중복 제거한 행의 수
    COUNT(DISTINCT lm.lead_manager_code) AS lm_cnt,
    COUNT(DISTINCT sm.senior_manager_code) AS sm_cnt,
    COUNT(DISTINCT ma.manager_code) AS ma_cnt,
    COUNT(DISTINCT em.employee_code) AS em_cnt
FROM (
SELECT
    company_code,
    founder
FROM company
) AS fo
# 1. founder -> 수석관리자 연결
INNER JOIN lead_manager AS lm
ON fo.company_code = lm.company_code
# 2. 수석관리자 -> 선임관리자 연결
INNER JOIN senior_manager AS sm
ON lm.lead_manager_code = sm.lead_manager_code
# 3. 선임관리자 -> 관리자 연결
INNER JOIN manager AS ma
ON sm.senior_manager_code = ma.senior_manager_code
# 4. 관리자 -> 직원 연결
INNER JOIN employee AS em
ON ma.manager_code = em.manager_code
# 5. 회사 별 창립자 별 그룹화
GROUP BY
    fo.company_code,
    fo.founder
# 7. 정렬
ORDER BY
    company_code ASC
    