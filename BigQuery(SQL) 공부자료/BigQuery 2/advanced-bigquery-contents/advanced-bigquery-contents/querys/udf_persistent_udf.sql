CREATE FUNCTION advanced.add_two_and_multiple_three(x INT64)
RETURNS INT64
AS (
  (x + 2) * 3
);

SELECT
  advanced.add_two_and_multiple_three(3)