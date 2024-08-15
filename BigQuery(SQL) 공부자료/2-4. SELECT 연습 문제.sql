-- 1. trainer 테이블에 있는 모든 데이터를 보여주는 SQL쿼리를 작성해주세요
-- SELECT 
--   *
-- FROM `inflearn-bigquery-study-420008.basic.trainer`

-- 2. trainer 테이블에 있는 트레이너의 name을 출력하는 쿼리를 작성해주세요.
-- SELECT
--   name
-- FROM basic.trainer

-- 3. trainer 테이블에 있는 트레이너의 name, age를 출력하는 쿼리를 작성해주세요
-- SELECT
--   name,age
-- FROM basic.trainer

-- 4. trainer 테이블에서 id가 3인 트레이너의 name,age,hometown을 출력하는 쿼리를 작성해주세요
-- SELECT
--   name,
--   age,
--   hometown
-- FROM basic.trainer
-- WHERE id = 3

# 현업에서는 이름, 나이를 알려주세요 => 컬럼의 의미를 파악해서 작성해야 함 => 어떤 컬럼을 요구하는지, 어떤컬럼을 봐야하는지?

-- 5. pokemon 테이블에서 "피카츄"의 공격력과 체력을 확인할 수 있는 쿼리를 작성해주세요
-- SELECT
--   hp,
--   attack
-- FROM basic.pokemon
-- WHERE kor_name = "피카츄"

# 확인절차
SELECT *
FROM basic.pokemon
WHERE kor_name = "피카츄"