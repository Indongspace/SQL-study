-- 연습문제 데이터셋 생성하기
-- CREATE OR REPLACE TABLE advanced.array_exercises AS (
--   SELECT
--   movie_id,
--   title,
--   actors,
--   genres
--   FROM (
--     SELECT
--       1 AS movie_id,
--       'Avengers:Endgame' AS title,
--       ARRAY<STRUCT<actor STRING, character STRING>>[
--         STRUCT('Robert Downey Jr.', 'Tony Stark'),
--         STRUCT('Chris Evans', 'Steve Rogers')] AS actors,
--       ARRAY<STRING>['Action', 'Adventure', 'Drama'] AS genres
--     UNION ALL
--     SELECT
--     2,
--     'Inception',
--     ARRAY<STRUCT<actor STRING, character STRING>>[
--       STRUCT('Leonardo DiCaprio', 'Cobb'),
--       STRUCT('Joseph Gordon-Levitt', 'Arthur')
--     ],
--     ARRAY<STRING>['Action', 'Adventure', 'Sci-Fi']
--     UNION ALL
--     SELECT
--     3,
--     'The Dark Knight',
--     ARRAY<STRUCT<actor STRING, character STRING>>[
--       STRUCT('Christian Bale', 'Bruce Wayne'),
--       STRUCT('Heath Ledger', 'Joker')
--     ],
--     ARRAY<STRING>['Action', 'Crime', 'Drama']
--   )
-- )

-- 1) array_exercises 테이블에서 각 영화(title)별로 장르(genres)를 UNNEST해서 보여주세요
-- SELECT
--   title,
--   genre
-- FROM advanced.array_exercises
-- CROSS JOIN UNNEST(genres) AS genre
# SELECT 절에서 새로운 이름으로 사용한다. 기존의 ARRAY_COLUMN은 사용하지 않는다

-- 2) array_exercises 테이블에서 각 영화(title)별로 배우(actor)와 배역(character)을 보여주세요. 배우와 배역은 별도의 컬럼으로 나와야 합니다
-- SELECT
--   title,
--   # actors,
--   # actors = [STRUCT(STRING, STRING)]
--   # actors[SAFE_OFFSET(0)],
--   -- actors[SAFE_OFFSET(0)].actor AS first_actor,
--   -- actors[SAFE_OFFSET(0)].character AS first_character,
--   -- actors[SAFE_OFFSET(1)].actor AS second_actor,
--   -- actors[SAFE_OFFSET(1)].character AS second_character
--   # => 매번 SAFE_OFFSET을 지정해야 함
--   actor.actor,
--   actor.character
-- FROM advanced.array_exercises 
-- CROSS JOIN UNNEST(actors) AS actor

-- 3) array_exercises 테이블에서 각 영화(title)별로 배우(actor), 배역(character), 장르(genre)를 출력하세요. 한 Row에 배우, 배역, 장르가 모두 표시되어야 합니다
-- SELECT
--   title,
--   actor.actor,
--   actor.character,
--   genre
-- FROM `advanced.array_exercises`
-- CROSS JOIN UNNEST(actors) AS actor,
-- UNNEST(genres) AS genre
-- # UNNEST를 2번 연속 사용할 수 있다
-- WHERE
--   actor.actor = 'Chris Evans' AND
--   genre = 'Action'
# actors : ARRAY<STRUCT> => UNNEST => STRUCT<actor STRING, character STRING>
# genres : ARRAY<STRING> => UNNEST => STRING

# 일괄수정 ctrl + d

# 앱 로그 데이터 => UNNEST 하기!
# 앱 로그 데이터(app_logs) 배열 풀기
# 4) 앱 로그 데이터(app_logs)의 배열을 풀어주세요
# version 1
-- SELECT
--   user_id,
--   event_date,
--   event_name,
--   user_pseudo_id,
--   event_param.key,
--   event_param.value.string_value,
--   event_param.value.int_value
-- FROM advanced.app_logs
-- CROSS JOIN UNNEST(event_params) AS event_param
# version 2
WITH base AS (
  SELECT
    event_date,
    event_timestamp,
    event_name,
    event_param.key AS key,
    event_param.value.string_value,
    event_param.value.int_value,
    user_id
  FROM advanced.app_logs
  CROSS JOIN UNNEST(event_params) AS event_param
  WHERE
    event_date = '2022-08-01'
)

SELECT
  event_date,
  event_name,
  COUNT(DISTINCT user_id) AS cnt
FROM base
GROUP BY ALL
ORDER BY
  cnt DESC
# 마지막 연습 문제 : 이 데이터를 직접 쿼리하면서 여러분들이 가설을 만들고, 그 가설에 대해 레포트를 작성해주세요


