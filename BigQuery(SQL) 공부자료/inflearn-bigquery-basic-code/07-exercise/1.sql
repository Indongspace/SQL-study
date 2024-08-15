-- 1. 각 트레이너별로 가진 포켓몬의 평균 레벨을 계산하고, 그 중 평균 레벨이 가장 높은 트레이너의 이름과 평균 레벨을 출력해주세요.
# 쿼리를 작성하는 목표, 확인할 지표 : 트레이너가 가진 포켓몬의 평균 레벨
# 쿼리 계산 방법 : 트레이너 + 트레이너포켓몬 + AVG
# 데이터의 기간 : X
# 사용할 테이블: trainer, trainer_pokemon
# Join KEY : trainer_pokemon.trainer_id = trainer.id, trainer_pokemon.pokemon_id = pokemon_id
# 데이터 특징 : trainer_pokemon에 Released는 제외해야 함(방출했으므로)

SELECT
  t.name,
  COUNT(tp.id) AS cnt,
  AVG(tp.level) AS avg_level
FROM basic.trainer_pokemon AS tp
LEFT JOIN basic.trainer AS t
ON tp.trainer_id = t.id
WHERE
  tp.status != "Released"
GROUP BY
  t.name
ORDER BY 
  avg_level DESC
LIMIT 3

-- 1. 각 트레이너별로 가진 포켓몬의 평균 레벨을 계산하고, 그 중 평균 레벨이 높은 TOP 3 트레이너의 이름과 보유한 포켓몬의 수, 평균 레벨을 출력해주세요.
# 쿼리를 작성하는 목표, 확인할 지표 : 트레이너의 이름, 보유한 포켓몬의 수, 평균 레벨
# 쿼리 계산 방법 : 트레이너가 보유한 포켓몬의 포켓몬의 수, 평균 레벨을 계산 + 트레이너 테이블과 연결해서 트레이너의 이름을 출력
# 데이터의 기간 : X
# 사용할 테이블: trainer_pokemon, trainer
# Join KEY : trainer_pokemon.trainer_id = trainer.id
# 데이터 특징 : trainer_pokemon의 status => Released는 방출

WITH trainer_avg_level AS (
  SELECT
# (1) 트레이너가 보유한 포켓몬의 평균 레벨, 포켓몬의 수
  trainer_id,
  ROUND(AVG(level), 2) AS avg_level,
  COUNT(id) AS pokemon_cnt
FROM basic.trainer_pokemon
WHERE
  status != "Released" # = : 같다. != 같지 않다
GROUP BY
  trainer_id
)

# (2) : (1)에서 만든 테이블 + trainer 테이블을 합쳐서 trainer의 name을 출력
SELECT
  t.name,
  tal.avg_level,
  tal.pokemon_cnt
FROM basic.trainer AS t
LEFT JOIN trainer_avg_level AS tal
ON t.id = tal.trainer_id
ORDER BY
  avg_level DESC
LIMIT 3

# 중복 제거 : DISTINCT를 사용해도 괜찮고, GROUP BY도 사용할 수 있음