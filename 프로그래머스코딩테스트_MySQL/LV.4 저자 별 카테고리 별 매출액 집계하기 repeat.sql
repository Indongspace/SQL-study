WITH total_sales AS (
    SELECT
        book_id,
        SUM(sales) AS sum_sales
    FROM book_sales
    WHERE
        DATE_FORMAT(sales_date, '%Y-%m') = '2022-01'
    GROUP BY
        book_id
)
SELECT 
    a.author_id,
    a.author_name,
    b.category,
    SUM(ts.sum_sales * b.price) AS total_sales
FROM book AS b
INNER JOIN author AS a
ON b.author_id = a.author_id
INNER JOIN total_sales AS ts
ON b.book_id = ts.book_id
GROUP BY
    a.author_id, 
    b.category
ORDER BY
    author_id ASC, category DESC
    