WITH sales_sub_category AS (
  SELECT
    sub_category,
    SUM(sales) AS sales_sub_category
  FROM records  
  GROUP BY
    sub_category
), sales_category AS (
  SELECT
    category,
    SUM(sales) AS sales_category
  FROM records
  GROUP BY
    category
)
SELECT  
  DISTINCT
    category,
    sub_category,
    ROUND(sales_sub_category, 2) AS sales_sub_category,
    ROUND(sales_category, 2) AS sales_category,
    ROUND(sales_total, 2) AS sales_total,
    ROUND((sales_sub_category * 100.0) / sales_category, 2) AS pct_in_category,
    ROUND((sales_sub_category * 100.0) / sales_total, 2) AS pct_in_total
FROM (
  SELECT
    r.category,
    r.sub_category,
    sc.sales_sub_category,
    c.sales_category,
    SUM(r.sales) OVER() AS sales_total
  FROM records AS r 
  LEFT JOIN sales_sub_category AS sc 
  ON r.sub_category = sc.sub_category
  LEFT JOIN sales_category AS c 
  ON r.category = c.category 
)
