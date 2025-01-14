WITH mentee AS (
  SELECT
    *
  FROM employees 
  WHERE
    join_date BETWEEN '2021-09-30' AND '2021-12-31'
), mento AS (
  SELECT
    *
  FROM employees
  WHERE
    employee_id NOT IN (SELECT employee_id FROM mentee) AND
    julianday('2021-12-31') - julianday(join_date) >= 2 * 365
)
SELECT
  e.employee_id AS mentee_id,
  e.name AS mentee_name, 
  o.employee_id AS mentor_id,
  o.name AS mentor_name
FROM mento AS o
LEFT JOIN mentee AS e 
ON o.department != e.department
ORDER BY
  mentee_id ASC, mentor_id ASC  
