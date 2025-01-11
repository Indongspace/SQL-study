WITH HR_GRADE AS (
    SELECT
        emp_no,
        AVG(score) AS score
    FROM hr_grade
    GROUP BY
        emp_no
), base AS (
    SELECT
        e.emp_no,
        e.emp_name,
        CASE
            WHEN g.score >= 96 THEN 'S'
            WHEN g.score >= 90 THEN 'A'
            WHEN g.score >= 80 THEN 'B'
            ELSE 'C'
        END AS grade,
        e.sal
    FROM HR_EMPLOYEES AS e
    INNER JOIN HR_GRADE AS g
    ON e.emp_no = g.emp_no
)
SELECT
    emp_no,
    emp_name,
    grade,
    CASE
        WHEN grade = 'S' THEN sal * 0.2
        WHEN grade = 'A' THEN sal * 0.15
        WHEN grade = 'B' THEN sal * 0.1
        WHEN grade = 'C' THEN 0
    END AS bonus
FROM base
ORDER BY
    emp_no ASC
    