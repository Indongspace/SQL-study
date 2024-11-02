SELECT
    GROUP_CONCAT(numb SEPARATOR '&')
FROM (SELECT @num := @num + 1 AS numb
      FROM information_schema.tables AS t1, 
           information_schema.tables AS t2,
           (SELECT @num := 1) AS temp) AS tempnum
WHERE
 numb <= 1000 
 AND NOT EXISTS (SELECT *
            FROM (SELECT @nu := @nu + 1 AS numa
                  FROM information_schema.tables AS t1, 
                       information_schema.tables AS t2,
                       (SELECT @nu := 1) AS temp
                LIMIT 1000) AS tempnum1
            WHERE
                FLOOR(numb/numa) = (numb/numa) AND
                numb > numa AND
                numa > 1)
     