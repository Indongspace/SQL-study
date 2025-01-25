SELECT
  sido,
  sigungu,
  COUNT(cafe_id) AS cnt 
FROM (
SELECT
  SUBSTR(address, 1, INSTR(address, ' ') - 1) AS sido,
  SUBSTR(address, INSTR(address, ' ') + 1, INSTR(SUBSTR(address, INSTR(address, ' ') + 1), ' ') - 1) AS sigungu,
  cafe_id
FROM cafes
)
GROUP BY
  sido, sigungu
ORDER BY
  cnt DESC 
