SELECT
  e1.user_a_id,
  e1.user_b_id,
  e2.user_b_id AS user_c_id
FROM edges AS e1
INNER JOIN edges AS e2
ON e1.user_b_id = e2.user_a_id
INNER JOIN edges AS e3
ON e1.user_a_id = e3.user_a_id AND e2.user_b_id = e3.user_b_id
WHERE
  3820 IN (e1.user_a_id, e1.user_b_id, e2.user_b_id) AND
  e1.user_a_id < e1.user_b_id AND
  e1.user_b_id < e2.user_b_id
  