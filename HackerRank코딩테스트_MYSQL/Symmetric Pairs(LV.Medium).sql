-- You are given a table, Functions, containing two columns: X and Y.
-- Two pairs (X1, Y1) and (X2, Y2) are said to be symmetric pairs if X1 = Y2 and X2 = Y1.

-- Write a query to output all such symmetric pairs in ascending order by the value of X. List the rows such that X1 ≤ Y1.

-- 두 개의 열이 포함된 함수라는 표가 주어집니다: X와 Y.
-- X1 = Y2이고 X2 = Y1인 경우 두 쌍(X1, Y1)과 (X2, Y2)은 대칭 쌍이라고 합니다.

-- 쿼리를 작성하여 모든 대칭 쌍을 X 값만큼 오름차순으로 출력합니다. X1 ≤ Y1이 되도록 행을 나열합니다.

SELECT
    BASE.X,
    BASE.Y
FROM (
    SELECT
        IF(X <= Y, X, Y) AS X,
        IF(X <= Y, Y, X) AS Y
    FROM FUNCTIONS
) AS BASE
GROUP BY
    BASE.X,
    BASE.Y
HAVING
    COUNT(*) >= 2
ORDER BY
    X ASC
    