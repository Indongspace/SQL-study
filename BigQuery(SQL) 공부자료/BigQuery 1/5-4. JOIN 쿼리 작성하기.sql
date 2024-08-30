# LEFT : trainer_pokemon
# RIGHT : trainer
# RIGHT : pokemon
SELECT
  -- tp.id,
  -- tp.trainer_id,
  -- tp.pokemon_id,
  -- t.id, # id라는 결과가 중복이여서 이렇게 설정 id_1
  -- t.age,
  -- t.hometown
  tp.*,
  t.* EXCEPT(id), # trainer_id => tp에 있으니 그걸 활용
  p.* EXCEPT(id) # pokemon_id => tp에 있으니 그걸 활용
FROM basic.trainer_pokemon AS tp
LEFT JOIN basic.trainer AS t
ON tp.trainer_id = t.id
# ON : Join KEY를 기입
LEFT JOIN basic.pokemon AS p
ON tp.pokemon_id = p.id

