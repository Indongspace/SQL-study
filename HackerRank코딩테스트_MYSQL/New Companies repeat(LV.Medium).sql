SELECT
    c.company_code,
    c.founder,
    COUNT(DISTINCT lm.lead_manager_code) AS lm_cnt,
    COUNT(DISTINCT sm.senior_manager_code) AS sm_cnt,
    COUNT(DISTINCT m.manager_code) AS m_cnt,
    COUNT(DISTINCT e.employee_code) AS e_cnt
FROM company AS c
INNER JOIN lead_manager AS lm
ON c.company_code = lm.company_code
INNER JOIN senior_manager AS sm
ON lm.lead_manager_code = sm.lead_manager_code
INNER JOIN manager AS m
ON sm.senior_manager_code = m.senior_manager_code
INNER JOIN employee AS e
ON m.manager_code = e.manager_code
GROUP BY
    c.company_code,
    c.founder
ORDER BY
    company_code ASC
