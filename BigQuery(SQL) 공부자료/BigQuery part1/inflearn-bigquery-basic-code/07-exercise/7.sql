-- 7. 각 트레이너가 가진 포켓몬 중에서 공격력(attack)이 100 이상인 포켓몬과 100 미만인 포켓몬의 수를 각각 계산해주세요. 트레이너의 이름과 두 조건에 해당하는 포켓몬의 수를 출력해주세요
# 쿼리를 작성하는 목표, 확인할 지표 : 트레이너의 이름 | 공격력이 100 이상인 포켓몬의 수 | 100 미만인 포켓몬의 수 
# 쿼리 계산 방법 : COUNTIF
# 데이터의 기간 : X
# 사용할 테이블: trainer_pokemon, trainer
# Join KEY : trainer_pokemon.trainer_id = trainer.id
# 데이터 특징 : 보유한 포켓몬!

WITH active_and_training_pokemon AS (
  SELECT
    *
  FROM basic.trainer_pokemon
  WHERE
    status IN ("Active", "Training")
), trainer_high_and_low_attack_cnt AS (
  SELECT
    atp.trainer_id,
    # trainer_name은 이후에 JOIN
    COUNTIF(p.attack >= 100) AS high_attack_cnt,
    COUNTIF(p.attack < 100) AS low_attack_cnt
  FROM active_and_training_pokemon AS atp
  LEFT JOIN basic.pokemon AS p
  ON atp.pokemon_id = p.id
  GROUP BY
    atp.trainer_id
)

SELECT
  t.name,
  thala.*
FROM trainer_high_and_low_attack_cnt AS thala
LEFT JOIN basic.trainer AS t
ON thala.trainer_id = t.id

# 확인하고 싶다!
-- trainer_id = 5, high_attack_cnt = 0, low_attack_cnt = 7
