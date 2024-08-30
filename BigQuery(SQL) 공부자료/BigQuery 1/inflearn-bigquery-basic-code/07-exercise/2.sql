-- 2. 각 포켓몬 타입1을 기준으로 가장 많이 포획된(방출 여부 상관없음) 포켓몬의 타입1, 포켓몬의 이름과 포획 횟수를 출력해주세요.
# 쿼리를 작성하는 목표, 확인할 지표 : 포켓몬 타입1, 포켓몬 이름, 포켓몬의 포획 횟수
# 쿼리 계산 방법 : trainer_pokemon + pokemon type1, kor_name
# 데이터의 기간 : X
# 사용할 테이블: trainer_pokemon, pokemon
# Join KEY : trainer_pokemon.pokemon_id = pokemon.id
# 데이터 특징 : X

SELECT
  type1,
  kor_name,
  COUNT(tp.id) as cnt
FROM basic.trainer_pokemon AS tp
LEFT JOIN basic.pokemon AS p 
ON tp.pokemon_id = p.id
GROUP BY
  type1,
  kor_name
ORDER BY
  cnt DESC
LIMIT 3
