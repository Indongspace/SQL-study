WITH Ranked AS (
    SELECT DISTINCT author, year
    FROM books
    WHERE genre = 'Fiction'
),
YearGroups AS (
    SELECT author, year,
           year - ROW_NUMBER() OVER (PARTITION BY author ORDER BY year) AS grp
    FROM Ranked
),
Grouped AS (
    SELECT author, MAX(year) AS year, COUNT(*) AS depth
    FROM YearGroups
    GROUP BY author, grp
    HAVING COUNT(*) >= 5
)
SELECT author, year, depth
FROM Grouped
ORDER BY year DESC, depth DESC;
