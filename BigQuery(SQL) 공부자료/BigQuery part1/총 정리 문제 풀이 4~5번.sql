-- 4.가장승리가많은트레이너ID,트레이너의이름,승리한횟수,보유한포켓몬의수,평균포켓몬의레벨을출력해주세요.
-- 단,포켓몬의레벨은소수점2째자리에서 반올림해주세요
-- 참고-반올림함수:ROUND
# 쿼리를 작성하는 목표, 확인할 지표 : 가장 승리가 많은 트레이너, 트레이너 이름, 승리 횟수, 보유한 포켓몬 수, 평균 포켓몬 레벨
# 쿼리 계산 방법 : battle테이블 => winner_id, 승리 횟수를 COUNT + 트레이너 이름 + trainer_pokemon의 포켓몬 수, 포켓몬 레벨
# 데이터의 기간 : 
# 사용할 테이블 : battle, trainer, trainer_pokemon
# Join KEY : battle.winner_id = trainer_id => ( ).trainer_id = trainer_pokemon.trainer_id
# 데이터 특징:

-- # (1) winner_id, COUNT(승리 횟수)
-- WITH winner_counts AS (
--   SELECT
--     winner_id,
--     COUNT(winner_id) AS win_counts
--   FROM basic.battle
--   WHERE
--     winner_id IS NOT NULL 
--   GROUP BY
--     winner_id
-- ), top_winner AS (
--   # (2) 이름을 추가
--   SELECT
--     wc.winner_id AS trainer_id,
--     wc.win_counts,
--     t.name AS trainer_name
--   FROM winner_counts AS wc
--   LEFT JOIN basic.trainer AS t
--   ON wc.winner_id = t.id
--   ORDER BY
--     win_counts DESC
--   LIMIT 1
-- # 가장 승리가 많은
--   # 이름을 추가한 결과에서 필터링해서 가장 승리가 많은 trainer_id 1개만 뽑을 수도 있음
--   # 평균 포켓몬 레벨, 포켓몬 수 추가한 후에 trainer_id 1개만 뽑을 수 있음
--   # ORDER BY + LIMIT 1
--   # 둘 다 가능한 방법. 그러나 데이터가 많다면 첫번째 방법을 추천
--   # 결과를 어떻게 사용할까에 따라서 (계속 바꿔야 한다 혹은 TOP3 도 보고 싶을 것 같다 등) 다르게 선택
-- )
-- # (3) 평균 포켓몬 레벨, 포켓몬 수 추가
-- SELECT
--   tw.trainer_id,
--   tw.trainer_name,
--   tw.win_counts,
--   COUNT(tp.pokemon_id) AS pokemon_cnt,
--   ROUND(AVG(level),2) AS avg_level 
-- FROM top_winner AS tw
-- LEFT JOIN basic.trainer_pokemon AS tp
-- ON tw.trainer_id = tp.trainer_id
-- WHERE
--   tp.status != "Released"
-- GROUP BY
--   tw.trainer_id,
--   tw.trainer_name,
--   tw.win_counts
# JOIN이 3번 WITH문 잘 사용

-- 5.트레이너가잡았던포켓몬의총공격력(attack)과방어력(defense)의합을계산하고, 이 합이 가장높은트레이너를찾으세요
# 쿼리를 작성하는 목표, 확인할 지표 : 트레이너 포켓몬의 총 (공격+방어) 공방
# 쿼리 계산 방법 : trainer_pokemon => pokemon.attack + defense
# 데이터의 기간 : 
# 사용할 테이블 : trainer_pokemon, pokemon, trainer
# Join KEY : trainer_pokemon.pokemon_id = pokemon.id
# 데이터 특징 :

# (1) 트레이너가 보유한 포켓몬들의 attack, defense
WITH total_stats AS (
  SELECT
    tp.trainer_id,
    -- p.attack,
    -- p.defense,
    SUM(p.attack + p.defense) AS total_stat
  FROM basic.trainer_pokemon AS tp
  LEFT JOIN basic.pokemon AS p
  ON tp.pokemon_id = p.id 
  GROUP BY
    tp.trainer_id
)

SELECT
  t.name,
  ts.trainer_id,
  ts.total_stat
FROM total_stats AS ts
LEFT JOIN basic.trainer AS t 
ON ts.trainer_id = t.id
ORDER BY
  ts.total_stat DESC
LIMIT 1
