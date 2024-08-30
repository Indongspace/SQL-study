-- 1. 트레이너가 보유한 포켓몬들은 얼마나 있는지 알 수 있는 쿼리를 작성해주세요
# 쿼리를 작성하는 목표, 확인할 지표 : 포켓몬들이(이름 명시) 얼마나 있는지 알고 싶다! 포켓몬의 수.
# 쿼리 계산 방법 : trainer_pokemon(status가 Active, Training) + pokemon JOIN => 그 후에 GROUP BY 집계(COUNT)
# 데이터의 기간 : X
# 사용할 테이블: trainer_pokemon, pokemon
# Join KEY : trainer_pokemon.pokemon_id = pokemon.id
# 데이터 특징 : 
-- 보유했다의 정의는 status가 Active, Training인 경우를 의미
-- Released는 방출했다는 것을 의미

-- 1) trainer_pokemon에서 status가 Active, Training인 경우만 필터링(WHERE)
  -- 1)을 먼저 하는 것이 좋을까? 혹은 JOIN을 하고 그 후에 Active, Training을 필터링하는 것이 좋을까?
  -- JOIN을 할 테이블들을 일단 줄이고(Row 수를 줄인다) 그 후에 JOIN을 한다
  -- 연산량 관점에서 먼저 줄이고 JOIN이 효율적. 
  -- WHERE 조건을 안하고 JOIN을 한 후에 WHERE 조건을 건다고 하면
    -- 379 Row * Pokemon JOIN. 
    -- Active, Training의 조건을 설정한 후엔 333 Row * Pokemon 
  -- 핵심 : Table을 그대로 사용해야 하는가? 혹은 줄이고 쓰는게 내 목적에 맞는가?
-- 2) 필터링한 결과를 pokemon Table과 JOIN
-- 3) 2)의 결과에서 pokemon_name, COUNT(pokemon_id) AS pokemon_cnt

SELECT
  -- tp.*,
  -- p.id,
  -- p.kor_name  
  kor_name,
  COUNT(tp.id) AS pokemon_cnt
  -- JOIN할 때 자주 나올 수 있는 에러 <Column name id is ambiguous at> : id가 모호하다. 더 구체적으로(Specific하게) 말해달라
  -- JOIN에서 사용하는 테이블에 중복된 컬럼의 이름이 있으면 꼭 어떤 테이블의 컬럼인지 명시해야 함
  -- id => tp.id
FROM (
  -- 복잡하다! => 가독성 있는 쿼리 => WITH 문
  SELECT
    id,
    trainer_id,
    pokemon_id,
    status
  FROM basic.trainer_pokemon
  WHERE
    status IN ("Active", "Training")
) AS tp
LEFT JOIN basic.pokemon AS p
ON tp.pokemon_id = p.id
-- SELECT FROM (JOIN) WHERE GROUP BY
-- WHERE
  -- status IN ("Active", "Training")
  -- 1=1 # 1=1은 무조건 TRUE를 반환. "가"="가" => 모든 ROW를 출력해라!
  -- AND status = "Training"
  -- 쿼리를 작성할 때 값을 바꿔가면서 실행해야 함 => 빨리 주석처리하기 위해서 앞에선 TRUE인 1=1을 넣고, AND 쓰고 빠르게 주석 처리
  -- 그러면 여기서 WHERE 쓰는게 더 좋은거 아니었냐? => 먼저 데이터를 줄이고 하는 것이 더 좋다!
GROUP BY
  kor_name
ORDER BY
  pokemon_cnt DESC



-- -- 1. 트레이너가 보유한 포켓몬들은 얼마나 있는지 알 수 있는 쿼리를 작성해주세요
-- -- 예상 결과 : 포켓몬 이름 | 포켓몬들의 수
-- # 쿼리를 작성하는 목표, 확인할 지표 : 트레이너가 보유한 포켓몬들이 얼마나 있는지 알고 싶다. 포켓몬들의 수를 포켓몬 이름과 함께 알고 싶다
-- # 쿼리 계산 방법 : 트레이너가 보유한 포켓몬을 확인할 수 있는 데이터(trainer_pokemon 단독으론 알 수 없음)가 있는가? => COUNT 함수
-- # 데이터의 기간 : X
-- # 사용할 테이블: trainer_pokemon + pokemon
-- # Join KEY : trainer_pokemon.pokemon_id = pokemon.id
-- # 데이터 특징 : trainer_pokemon에 트레이너가 보유한 포켓몬 정보가 존재. 그러나 여기엔 pokemon_name이 없기 때문에 pokemon 테이블을 JOIN

-- SELECT
--   kor_name,
--   COUNT(tp.id) AS cnt
-- FROM basic.trainer_pokemon AS tp
-- # 우리가 원하는 것 : 트레이나거 보유한 포켓몬 중에 얼마나 있는가!
-- # pokemon을 LEFT로 했다면, 잡히지 않은 포켓몬들은 우측에 NULL이 발생할 것
-- LEFT JOIN basic.pokemon AS p
-- ON tp.pokemon_id = p.id
-- -- WHERE
-- --   1 = 1 # 그냥 TRUE을 반환하는 조건절
-- GROUP BY
--   kor_name
-- ORDER BY
--   cnt DESC


-- 2. 각 트레이너가 가진 포켓몬 중에서 'Grass' 타입의 포켓몬 수를 계산해주세요
-- (단, 편의를 위해 type1 기준으로 계산해주세요)
# 쿼리를 작성하는 목표, 확인할 지표 : 트레이너가 보유한 포켓몬 중에서 Grass 타입의 포켓몬 수를 알고 싶다!
# 쿼리 계산 방법 : 트레이너가 보유한 포켓몬 조건 설정 => Grass 타입으로 WHERE 조건 걸어서 COUNT
# 데이터의 기간 : X
# 사용할 테이블: trainer_pokemon, pokemon
  -- 언제 왼쪽에 둘까요?
  -- 우리가 풀려고 하는 문제에서 어떤 테이블이 기준이 되어야 할까?
  -- trainer_pokemon 왼쪽?
  -- pokemon이 왼쪽?
  -- trainer_pokemon 테이블 : 트레이너가 잡은 히스토리가 저장된 테이블. 트레이너가 보유했던(보유한) 포켓몬이 얼마나 있는지 알려줌
  -- pokemon : 포켓몬의 메타 정보. 상품은 고정되어 있고, 그 상품을 주문하면서 주문이 생김 
    -- 모든 포켓몬의 정보가 저장됨.
    -- pokemon을 왼쪽에 두면 => pokemon 중에 보유되지 않았던 포켓몬들은 trainer_pokemon에 없을 것. NULL
    -- trainer_pokemon을 왼쪽에 두면 : 트레이너가 보유했던 포켓몬들을 기반으로 포켓몬 데이터만 추가. NULL이 추가되지 않음
    -- 기준이 되는 테이블은 내가 구하고자 하는 데이터가 어디에 제일 잘 저장되어 있는가?
    -- JOIN을 할 수 있는 Key 같아 보이는 것이 많은 테이블을 제일 왼쪽으로 둠(예외 있음)
# Join KEY : trainer_pokemon.pokemon_id = pokemon.id
# 데이터 특징 : 1번 문제와 동일

SELECT
  -- tp.*,
  p.type1,
  COUNT(tp.id) AS pokemon_cnt
FROM (
  SELECT
    id,
    trainer_id,
    pokemon_id,
    status
  FROM basic.trainer_pokemon
  -- Table "trainer_pokemon" must be qualified with a dataset (e.g. dataset.table). => basic 명시 안함
  WHERE
    status IN ("Active", "Training")
) AS tp
LEFT JOIN basic.pokemon AS p
ON tp.pokemon_id = p.id
WHERE
  type1 = "Grass"
GROUP BY
  type1
ORDER BY
  2 DESC # 2 대신에 pokemon_cnt도 가능


-- 3. 트레이너의 고향(hometown)과 포켓몬을 포획한 위치(location)를 비교하여, 자신의 고향에서 포켓몬을 포획한 트레이너의 수를 계산해주세요.
# 쿼리를 작성하는 목표, 확인할 지표 : 트레이너 고향과 포켓몬의 포획 위치가 같은 트레이너의 수를 계산하기!
# 쿼리 계산 방법 : trainer(hometown), trainer_pokemon(location) JOIN => hometown = location => 트레이너의 수 COUNT
# 데이터의 기간 : X
# 사용할 테이블: trainer, trainer_pokemon
# Join KEY : trainer.id = trainer_pokemon.trainer_id
-- 어디를 왼쪽에 써야할까? trainer_pokemon을 LEFT로 할 것 같음(실제로 푼다면)
-- trainer를 왼쪽에 두고 쿼리를 작성
# 데이터 특징 : 
-- - status 상관없이 구해주세요

SELECT
  COUNT(DISTINCT tp.trainer_id) AS trainer_uniq, # 트레이너의 수 => 28명
  -- COUNT(tp.trainer_id) AS trainer_cnt, # 트레이너와 포켓몬이 같은 건이 43개
FROM basic.trainer AS t
LEFT JOIN basic.trainer_pokemon AS tp
ON t.id = tp.trainer_id
WHERE
  tp.location IS NOT NULL
  AND t.hometown = tp.location
  -- trainer 중에 포켓몬을 잡아보지 못한 trainer가 있으면 NULL 조건을 걸어줘야 함. 지금 데이터에는 trainer 테이블에 있는 trainer들은 모두 포켓몬을 잡아봐서 신경쓰지 않아도 됨
-- trainer엔 특정 트레이너의 정보가 1개 들어있음(1 Row = 1 data)
-- JOIN을 하다보면 RIGHT에서 LEFT의 기준에 여러개가 있을 때 데이터가 더 많아지는 것처럼 보여요. trainer_pokemon에 Goh가 6마리 포켓몬을 가지고 있어서 이렇게 결과가 합쳐진 것
-- LEFT에 메타 정보를 두면 헷갈릴 수 있음


-- 4. Master 등급인 트레이너들은 어떤 타입(type1)의 포켓몬을 제일 많이 보유하고 있을까요?
# 쿼리를 작성하는 목표, 확인할 지표 : Master 등급의 트레이너들이 가장 많이 보유하고 있는 타입
# 쿼리 계산 방법 : trainer + pokemon + trainer_pokemon => Master 조건 설정(WHERE) => type1 GROUP BY + COUNT
# 데이터의 기간 : X
# 사용할 테이블: trainer, pokemon, trainer_pokemon
# Join KEY : trainer.id = trainer_pokemon.trainer_id, pokemon.id = trainer_pokemon.pokemon_id
  -- 2번 나오는 trainer_pokemon을 LEFT
# 데이터 특징 : 
-- - 보유했다의 정의는 1번 문제의 정의와 동일

SELECT
  type1,
  COUNT(tp.id) AS pokemon_cnt
FROM (
  SELECT
    id, 
    trainer_id,
    pokemon_id,
    status
  FROM basic.trainer_pokemon
  WHERE
    status IN ("Active", "Training")
) AS tp
LEFT JOIN basic.pokemon AS p
ON tp.pokemon_id = p.id
LEFT JOIN basic.trainer AS t
ON tp.trainer_id = t.id
# LEFT JOIN을 연속해서 2번 사용할 수 있다(N번)
WHERE
  t.achievement_level = "Master"
GROUP BY
  type1
ORDER BY
  2 DESC
LIMIT 1


-- 5. Incheon 출신 트레이너들은 1세대, 2세대 포켓몬을 각각 얼마나 보유하고 있나요?
# 쿼리를 작성하는 목표, 확인할 지표 : Inchecon 출신 트레이너들이 보유하고 있는 포켓몬 중에 세대 구분을 하고 싶다(1, 2)
# 쿼리 계산 방법 : trainer + trainer_pokemon + pokemon => Incheon 조건(WHERE) => 세대(generation)로 GROUP BY COUNT
# 데이터의 기간 : X
# 사용할 테이블: trainer, trainer_pokemon, pokemon
# Join KEY : trainer.id = trainer_pokemon.trainer_id, pokemon.id = trainer_pokemon.pokemon_id
# 데이터 특징 : 보유의 정의

SELECT
  generation,
  COUNT(tp.id) AS pokemon_cnt
FROM (
SELECT
  id,
  trainer_id,
  pokemon_id,
  status
FROM basic.trainer_pokemon
WHERE
  status IN ("Active", "Training")
) AS tp
LEFT JOIN basic.trainer AS t
ON tp.trainer_id = t.id 
-- Unrecognized name: trainer_pokemon at [22:4] : trainer_pokemon이 아니라 basic.trainer_pokemon은 인식할 것
  -- AS로 tp Alias를 줬기에 tp라고 작성해야 함
LEFT JOIN basic.pokemon AS p
ON tp.pokemon_id = p.id
WHERE
  t.hometown = "Incheon"
  -- 만약에 세대가 점점 데이터 늘어나서 1, 2세대가 아니라 3세대도 생기면 어떻게 할 것인가?
  -- 3세대가 생기면 3세대도 나오게 해줘! => 쿼리를 그대로 사용하면 됨
  -- 3세대가 생겨도 1, 2 세대만 나오게 해줘! => WHERE 조건에 generation IN (1, 2)
GROUP BY
  generation