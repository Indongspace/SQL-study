-- 1. 포켓몬 중에 type2가 없는 포켓몬의 수를 작성하는 쿼리를 작성해주세요
-- (힌트) ~가 없다 : 컬럼 IS NULL
-- 조건 : type2가 없는
  -- type2가 어떻게 생겼지? type2의 정의는 무엇이지?
-- NULL은 뭘까?
  -- 아무것도 없는 값. 값이 존재하지 않을 때 NULL
  -- type2 : NULL
  -- NULL 0이랑 다르고, ""과도 다름 => 값이 없는 상태
  -- 연산자 : IS NULL
  -- type2 IS NULL
  -- type2 = NULL은 안되냐? => X. NULL은 다른 값과 직접 비교할 수 없음. NULL = NULL 거짓이 아니라 알 수 없음
  -- 핵심 : NULL은 IS 연산자를 사용한다!
  -- type2 IS NOT NULL
-- 어떤 테이블? : pokemon
-- 어떤 컬럼 : 따로 없음. 포켓몬의 수만 남기면 됨
-- 어떻게 집계 : 포켓몬의 수 => COUNT 

-- SELECT
--   COUNT(id) AS cnt
-- FROM basic.pokemon
-- WHERE
--   (type2 IS NULL)
--   OR (type1 = "Fire")
  -- WHERE 절에서 여러 조건을 연결하고 싶은 경우 => AND 조건을 사용
  -- OR 조건 => (  ) OR (  )


-- 2. type2가 없는 포켓몬의 type1과 type1의 포켓몬 수를 알려주는 쿼리를 작성해주세요. 단, type1의 포켓몬 수가 큰 순으로 정렬해주세요
-- 테이블 : pokemon 
-- 조건 : type2가 없는 포켓몬
-- 컬럼 : type1
-- 집계 : 포켓몬 수 => COUNT
-- 정렬 : type1의 포켓몬 수가 큰 순으로 정렬 => ORDER BY. 큰 순으로 : 큰 것부터 작은 것으로 => 내림차순(DESC) => ORDER BY 포켓몬 수 DESC

-- SELECT
--   type1,
--   -- 빨간 밑줄 : 에러 메세지 
--   COUNT(id) AS pokemon_cnt
--   -- 집계 함수는 GROUP BY 와 같이 다님. 집계하는 기준(컬럼)이 없으면 COUNT만 쓸 수 있으나, 집계하는 기준이 있다면 그 기준 컬럼을 GROUP BY에 써줘야 한다
-- FROM basic.pokemon
-- WHERE 
--   type2 IS NULL
-- GROUP BY
--   type1
-- ORDER BY
--   pokemon_cnt DESC

-- 3. type2 상관없이 type1의 포켓몬 수를 알 수 있는 쿼리를 작성해주세요
-- 테이블 : pokemon
-- 조건 : type2 상관없이 => 조건인가? 아닌가? => 조건이 아님
-- 컬럼 : type1
-- 집계 : 포켓몬 수 => COUNT

-- SELECT
--   type1,
--   COUNT(id) AS pokemon_cnt,
--   COUNT(DISTINCT id) AS pokemon_cnt2
--   -- DISTINCT 언제 쓸까? => 고유한 값만 보고 싶을 때 사용한다. Unique한 값만 알고 싶은 경우 사용
--   -- COUNT(id) = COUNT(DISTINCT id)
--   -- id를 설계할 때, 중복이 없게 설계했음. 그래서 두개의 결과가 동일
--   -- 어떤 컬럼은 중복이 있게 설계되곤 함
--   -- DISTINCT도 걸어서 보시고, 어떤 값이 더 맞을까? 
--   -- DISTINCT: DAU(Daily Active User)
--   -- Active한 유저의 수를 하루 단위로 집계
--   -- COUNT(DISTINCT user_id) AS dau => 이런 데이터를 저장하는 곳에 접속 기록, 이벤트 로그가 여러 Row가 존재 => Unique => DISTINCT
-- FROM basic.pokemon
-- GROUP BY
--   type1


-- 4. 전설 여부에 따른 포켓몬 수를 알 수 있는 쿼리를 작성해주세요
-- 테이블 : pokemon
-- 조건 : 없음
-- 컬럼 : 전설(is_legendary)
-- 집계 : 포켓몬 수

-- SELECT
--   is_legendary,
--   -- 컬럼의 이름 앞부분 일부를 입력하고 기다리면 자동 완성을 할 수 있는데, 이 때 찾아서 엔터
--   COUNT(id) AS pokemon_cnt
-- FROM basic.pokemon
-- GROUP BY
--   is_legendary
  -- 1
-- ORDER BY 2 DESC

-- GROUP BY : is_legendary가 길다. GROUP BY에 컬럼이 많이 있을 수 있음(5개 + COUNT)
-- GROUP BY 1 => SELECT의 첫 컬럼을 의미
-- ORDER BY에도 1, 2 등을 사용할 수 있음
-- 1, 2 => 쿼리를 빠르게 작성하고, 결과를 보는 과정. 완성된 쿼리문에서는 1, 2 같은 표현보단 명확하게 컬럼을 명시하는게 좋습니다(가독성 관점)

-- 5. 동명 이인이 있는 이름은 무엇일까요? (한번에 찾으려고 하지 않고 단계적으로 가도 괜찮아요)
-- 테이블 : trainer
-- 조건 : 같은 이름이 2개 이상(동명이인) => COUNT(name) => 2개 이상
-- 컬럼 : 이름
-- 집계 : COUNT

-- SELECT
--   name, 
--   COUNT(name) AS trainer_cnt
-- FROM basic.trainer
-- GROUP BY
--   name
-- -- 집계 후 조건 => HAVING. FROM 절의 테이블 조건 => WHERE
-- HAVING
--   trainer_cnt >= 2
-- WHERE : 원본 데이터 FROM 절에 있는 데이터에 조건을 설정하고 싶은 경우
-- HAVING : GROUP BY와 함께 집계 결과에 조건을 설정하고 싶은 경우
-- 서브쿼리 : 쿼리문을 한번 감싸서 다른 쿼리문에서 사용할 수 있음
-- SELECT
--   *
-- FROM (
--   SELECT
--     name, 
--     COUNT(name) AS trainer_cnt
--   FROM basic.trainer
--   GROUP BY
--     name
-- )
-- WHERE
--   trainer_cnt >= 2
-- HAVING을 쓰면 쿼리 줄 수가 줄어든다 


-- 6. trainer 테이블에서 “Iris” 트레이너의 정보를 알 수 있는 쿼리를 작성해주세요
-- 테이블 : trainer 
-- 조건 : 트레이너의 이름 = "Iris"
-- 컬럼 : 정보 => 모든 컬럼
-- 집계 : X

-- SELECT
--   *
-- FROM basic.trainer
-- WHERE
--   name = "Iris"


-- 7. trainer 테이블에서 “Iris”,”Whitney”, “Cynthia” 트레이너의 정보를 알 수 있는 쿼리를 작성해주세요
-- (힌트) 컬럼 IN ("Iris", "Whitney", "Cynthia")
-- 테이블 : trainer
-- 조건 : 이름 = “Iris”,”Whitney”, “Cynthia” 중에 있으면 추출
-- 컬럼 : 정보 -> *
-- 집계 : 없음

-- SELECT
--   *
-- FROM basic.trainer
-- WHERE
--   -- (name = "Iris")
--   -- OR (name = "Cynthia")
--   -- OR (name = "Whitney")
--   # OR 조건으로 쓰는거 너무 길다. 귀찮다 => IN => name에 괄호 안의 Value가 있는 Row만 추출
--   name IN ("Iris", "Cynthia", "Whitney")

-- 8. 전체 포켓몬 수는 얼마나 되나요?
-- 테이블 : pokemon 
-- 조건 : 없음
-- 컬럼 : 없음
-- 집계 : 포켓몬 수 => COUNT(id)

-- SELECT
--   COUNT(id) AS pokemon_cnt
--   -- Unrecognized name: name at [162:9] => 컬럼 이름에 오타일 가능성이 있음
-- FROM basic.pokemon

-- 9. 세대(generation) 별로 포켓몬 수가 얼마나 되는지 알 수 있는 쿼리를 작성해주세요
-- 테이블 : pokemon
-- 조건 : 없음
-- 컬럼 : 세대(generation)
-- 집계 : 포켓몬 수 => COUNT

-- SELECT
--   generation,
--   COUNT(id) AS pokemon_cnt
-- FROM basic.pokemon
-- GROUP BY 
--   generation

-- 10. type2가 존재하는 포켓몬의 수는 얼마나 되나요?
-- 테이블 : pokemon
-- 조건 : type2가 존재하는! => type2 IS NOT NULL
-- 컬럼 : X
-- 집계 : 포켓몬의 수 => COUNT
-- 전체 116행 => COUNT(id)=> 동일한가?
-- SELECT
--   COUNT(id) AS pokemon_cnt
-- FROM basic.pokemon
-- WHERE
--   type2 IS NOT NULL


-- 11. type2가 있는 포켓몬 중에 제일 많은 type1은 무엇인가요?
-- 테이블 : pokemon
-- 조건 : type2가 있는
-- 컬럼 : type1
-- 집계 : 제일 많은 => COUNT

-- SELECT
--   type1,
--   COUNT(id) AS pokemon_cnt
-- FROM basic.pokemon
-- WHERE
--   type2 IS NOT NULL
-- GROUP BY
--   type1
-- ORDER BY 
--   pokemon_cnt DESC
-- LIMIT 1

-- 12. 단일(하나의 타입만 있는) 타입 포켓몬 중 많은 type1은 무엇일까요?
-- 테이블 : pokemon
-- 조건 : 단일 타입 => 하나의 타입만 존재 => type2가 NULL(값이 없어야 한다)
-- 컬럼 : type1
-- 집계 : COUNT
-- SELECT
--   type1,
--   COUNT(id) AS pokemon_cnt
-- FROM basic.pokemon
-- WHERE
--   type2 IS NULL
-- GROUP BY
--   type1
-- ORDER BY
--   pokemon_cnt DESC
-- LIMIT 1

-- 13. 포켓몬의 이름에 "파"가 들어가는 포켓몬은 어떤 포켓몬이 있을까요?
-- (힌트) 컬럼 LIKE "파%"
-- 테이블 : pokemon
-- 조건 : kor_name에 "파"가 들어가는 포켓몬
-- 컬럼 : 어떤 포켓몬이 있을까요? name
-- 집계 : 없음

-- SELECT
--   kor_name
-- FROM basic.pokemon
-- WHERE
--   kor_name LIKE "%파%"
-- 컬럼 LIKE "특정단어%". %는 앞에도 붙을 수 있고, 뒤에도 붙을 수 있음. 
-- "%파" : 파로 끝나는 단어, "파%" : 파로 시작하는 단어. "%파%" : 파가 들어간 단어
-- 문자열 컬럼에서 특정 단어가 포함되어 있는지 알고 싶은 경우엔 LIKE를 사용하면 편함

-- 14. 뱃지가 6개 이상인 트레이너는 몇 명이 있나요?
-- 테이블 : trainer 
-- 조건 : 뱃지가 6개 이상(badge_count >= 6)
-- 컬럼 : 없음
-- 집계 : 트레이너의 수(COUNT)
-- SELECT
--   COUNT(id) AS trainer_cnt
-- FROM basic.trainer
-- WHERE
--   badge_count >= 6

-- 15. 트레이너가 보유한 포켓몬(trainer_pokemon)이 제일 많은 트레이너는 누구일까요?
-- 테이블 : trainer_pokemon
-- 조건 : 없음
-- 컬럼 : trainer_id 
-- 집계 : 포켓몬의 수 => COUNT
-- SELECT
--   trainer_id,
--   COUNT(pokemon_id) AS pokemon_cnt,
--   COUNT(DISTINCT pokemon_id) AS pokemon_cnt2
-- FROM basic.trainer_pokemon
-- GROUP BY
--   trainer_id
-- 16. 포켓몬을 많이 풀어준 트레이너는 누구일까요?
-- 테이블 : trainer_pokemon
-- 조건 : status = "Released" (풀어준)
-- 컬럼 : trainer_id
-- 집계 : 많이 풀어준 => COUNT
-- 많이 풀어준 => ORDER BY + LIMIT
-- SELECT
--   trainer_id,
--   COUNT(pokemon_id) AS pokemon_cnt
-- FROM basic.trainer_pokemon
-- WHERE
--   status = "Released"
-- GROUP BY
--   trainer_id
-- ORDER BY 
--   pokemon_cnt DESC
-- LIMIT 1

-- 17. 트레이너 별로 풀어준 포켓몬의 비율이 20%가 넘는 포켓몬 트레이너는 누구일까요?
-- 풀어준 포켓몬의 비율 = (풀어준 포켓몬 수/전체 포켓몬의 수)
-- (힌트) COUNTIF(조건)
-- 테이블 : trainer_pokemon
-- 조건 : 풀어준 포켓몬의 비율이 20%가 넘어야 한다
-- 컬럼 : trainer_id
-- 집계 : COUNTIF
-- COUNTIF(조건) : COUNTIF(컬럼 = "3")
-- released_ratio >= 0.2

-- SELECT
--   trainer_id,
--   COUNTIF(status = "Released") AS released_cnt, # 풀어준 포켓몬의 수
--   COUNT(pokemon_id) AS pokemon_cnt,
--   COUNTIF(status = "Released")/COUNT(pokemon_id) AS released_ratio
-- FROM basic.trainer_pokemon
-- GROUP BY
--   trainer_id
-- HAVING
--   released_ratio >= 0.2


