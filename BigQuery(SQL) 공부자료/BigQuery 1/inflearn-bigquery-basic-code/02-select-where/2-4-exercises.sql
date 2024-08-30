-- 1. trainer 테이블에 있는 모든 데이터를 보여주는 SQL 쿼리를 작성해주세요
-- 1) Trainer 테이블에 어떤 데이터가 있는지 확인해보자
-- 2) Trainer 테이블을 어디에 명시해야 할까? => FROM
-- 3) 필터링 조건이 있을까? => 모든 데이터 => 필터링을 할 필요가 없겠다
-- 4) 모든 데이터 => 모든 데이터 = 모든 컬럼일 수도 있겠다(추측) 쿼리 작성 => 애매하면 모든 데이터의 정의가 무엇인가?
-- SELECT
--   *
-- FROM `inflearn-bigquery.basic.trainer`

-- 2. trainer 테이블에 있는 트레이너의 name을 출력하는 쿼리를 작성해주세요
-- 1) trainer 테이블 사용
-- 2) name 컬럼을 사용
-- SELECT
--   name
-- FROM basic.trainer

-- 3. trainer 테이블에 있는 트레이너의 name, age를 출력하는 쿼리를 작성해주세요
-- 1) trainer 테이블 사용
-- 2) 조건 설정 없음
-- 3) name, age 컬럼 사용
-- SELECT
--   name,
--   age
-- FROM basic.trainer


-- 4. trainer의 테이블에서 id가 3인 트레이너의 name, age, hometown을 출력하는 쿼리를 작성해주세요
-- 1) trainer 테이블 사용
-- 2) 조건 설정 => id가 3인 
-- 3) 컬럼 : name, age, hometown
-- SELECT
--   name,
--   age,
--   hometown
-- FROM basic.trainer
-- WHERE
--   id = 3

# name, age, hometown => 영어로 명시되어 있는 경우엔 편함
# 현업에서는 이름, 나이를 알려주세요 => 컬럼의 의미를 파악해서 작성해야 함 => 어떤 컬럼을 요구하는지, 어떤 컬럼을 봐야하는지?

-- 5. pokemon 테이블에서 “피카츄”의 공격력과 체력을 확인할 수 있는 쿼리를 작성해주세요
-- 1) pokemon 테이블
-- 2) 조건? => "피카츄" kor_name = "피카츄"
-- 3) 공격력, 체력 => 테이블에서 어떤 컬럼인지 확인해야 함 => attack, hp

SELECT
  -- attack,
  -- hp
  *
FROM basic.pokemon
WHERE
  kor_name = "피카츄"




