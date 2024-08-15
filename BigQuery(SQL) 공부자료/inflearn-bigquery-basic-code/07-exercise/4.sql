WITH winner_counts AS (
  SELECT 
    winner_id, 
    COUNT(winner_id) AS win_count
  FROM basic.battle AS b
  GROUP BY 
    winner_id
), top_winner AS (
  SELECT 
    wc.winner_id,
    wc.win_count,
    t.name
  FROM winner_counts AS wc
  LEFT JOIN basic.trainer AS t
  ON wc.winner_id = t.id
  ORDER BY 
    win_count DESC
  LIMIT 1
), active_training_pokemon AS (
  SELECT
    id,
    trainer_id,
    pokemon_id,
    level
  FROM basic.trainer_pokemon
  WHERE
    status IN ("Active", "Training")
)

SELECT
  tw.winner_id,
  tw.name,
  tw.win_count,
  COUNT(atp.pokemon_id) AS total_pokemons,
  ROUND(AVG(atp.level), 2) AS average_pokemon_level
FROM top_winner AS tw
LEFT JOIN active_training_pokemon AS atp 
ON tw.winner_id = atp.trainer_id
GROUP BY 
  tw.winner_id, 
  tw.win_count,
  tw.name


-- 4. 가장 승리가 많은 트레이너 ID,  트레이너의 이름, 승리한 횟수, 보유한 포켓몬의 수, 평균 포켓몬의 레벨을 출력해주세요. 단, 포켓몬의 레벨은 소수점 2째 자리에서 반올림해주세요
# 쿼리를 작성하는 목표, 확인할 지표 : 가장 승리가 많은 트레이너, 트레이너 이름, 승리 횟수, 보유한 포켓몬 수, 평균 포켓몬 레벨
# 쿼리 계산 방법 : battle 테이블 => winner_id. 승리 횟수를 COUNT + 트레이너 이름 + trainer_pokemon의 포켓몬 수, 포켓몬 레벨
# 데이터의 기간 : X
# 사용할 테이블: battle, trainer, trainer_pokemon
# Join KEY : battle.winner_id = trainer.id => ( ).trainer_id = trainer_pokemon.trainer_id
# 데이터 특징 : battle 테이블을 확인하면서 쿼리해야겠다!

# (1) winner_id, COUNT(승리 횟수)
WITH winner_counts AS (
  SELECT
    winner_id,
    COUNT(winner_id) AS win_counts
  FROM basic.battle
  WHERE
    winner_id IS NOT NULL
  GROUP BY
    winner_id
), top_winner AS (
  # (2) 이름을 추가
  SELECT
    wc.winner_id AS trainer_id,
    wc.win_counts,
    t.name AS trainer_name
  FROM winner_counts AS wc
  LEFT JOIN basic.trainer AS t
  ON wc.winner_id = t.id
  ORDER BY 
    win_counts DESC
  LIMIT 1
)
# 가장 승리가 많은
  # ㄱ) 이름을 추가한 결과에서 필터링해서 가장 승리가 많은 trainer_id 1개만 뽑을 수도 있음
  # ㄴ) 평균 포켓몬 레벨, 포켓몬 수 추가한 후에 trainer_id 1개만 뽑을 수 있음
  # ORDER BY + LIMIT 1
  # 둘 다 가능한 방법. 그러나 데이터가 많다면 첫번째 방법(ㄱ)을 추천
  # 결과를 어떻게 사용할까에 따라서(계속 바꿔야 한다 혹은 TOP3도 보고 싶을 것 같다 등) 다르게 선택

# (3) 평균 포켓몬 레벨, 포켓몬 수 추가
SELECT
  tw.trainer_id,
  tw.trainer_name,
  tw.win_counts,
  COUNT(tp.pokemon_id) AS pokemon_cnt,
  ROUND(AVG(tp.level), 2) AS avg_level
FROM top_winner AS tw
LEFT JOIN basic.trainer_pokemon AS tp
ON tw.trainer_id = tp.trainer_id
WHERE
  tp.status IN ("Active", "Training")
GROUP BY
  tw.trainer_id,
  tw.trainer_name,
  tw.win_counts

# JOIN이 3번. WITH문을 잘 사용하면 좋겠다!