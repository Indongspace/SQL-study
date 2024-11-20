WITH row_num_cnt AS (
    SELECT
        lat_n,
        ROW_NUMBER() OVER(ORDER BY lat_n ASC) AS row_num,
        COUNT(*) OVER() AS row_cnt
    FROM station
)
SELECT
    DISTINCT median
FROM (
    SELECT
        CASE
            WHEN row_cnt % 2 = 0 THEN (SELECT ROUND(AVG(lat_n), 4) FROM row_num_cnt WHERE row_num IN ((row_cnt / 2), (row_cnt / 2) + 1))
            ELSE (SELECT ROUND(lat_n, 4) FROM row_num_cnt WHERE row_num = CEIL(row_cnt / 2))
            END AS median
    FROM row_num_cnt
) AS base                             
                                   
                                
