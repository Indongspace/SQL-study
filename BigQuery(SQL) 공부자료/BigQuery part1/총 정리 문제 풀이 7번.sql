-- 7.각트레이너가가진포켓몬중에서 공격력(attack)이100이상인포켓몬과 100미만인포켓몬의수를 각각계산해주세요.
-- 트레이너의 이름과 두조건에 해당하는포켓몬의수를 출력해주세요
# 쿼리를 작성하는 목표, 확인할 지표 : 트레이너의 이름 | 공격력이 100 이상인 포켓몬의 수 | 100 미만인 포켓몬의 수
# 쿼리 계산 방법 : COUNTIF
# 데이터의 기간 :
# 사용할 테이블 : trainer_pokemon, trainer
# Join KEY : trainer_pokemon.trainer_id = trainer.id
# 데이터 특징 : 보유한 포켓몬
WITH active_and_training_pokemon AS (
  SELECT
    *
  FROM basic.trainer_pokemon
  WHERE
    status != 'Released' 
), trainer_high_and_low_attack_cnt AS (
  SELECT
    -- atp.trainer_id,
    -- atp.pokemon_id,
    -- p.attack
    atp.trainer_id,
    COUNTIF(p.attack>=100) AS high_attack_cnt,
    COUNTIF(p.attack<100) AS low_attack_cnt
  FROM active_and_training_pokemon AS atp
  LEFT JOIN basic.pokemon AS p
  ON atp.pokemon_id = p.id
  GROUP BY
    atp.trainer_id
  -- WHERE
  --   atp.trainer_id = 5
  # 확인해보자
  -- trainer_id = 5, high_attack_cnt = 0, low_attack_cnt = 7
)

SELECT
  t.name,
  thala.*
FROM trainer_high_and_low_attack_cnt AS thala
LEFT JOIN basic.trainer AS t 
ON thala.trainer_id = t.id

