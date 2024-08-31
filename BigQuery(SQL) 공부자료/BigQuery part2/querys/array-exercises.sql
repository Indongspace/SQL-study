# 1) array_exercises 테이블에서 각 영화(title)별로 장르(genres)를 UNNEST해서 보여주세요
# ARRAY : 같은 타입의 여러 데이터를 저장하고 싶을 때
# ARRAY를 Flatten(평면화) => UNNEST
# UNNEST를 할 때는 CROSS JOIN + UNNEST(ARRAY_COLUMN)
# UNNEST(ARRAY_COLUMN) AS 새로운 이름
# SELECT 절에서 새로운 이름으로 사용한다. 기존의 ARRAY_COLUMN은 사용하지 않는다!

-- SELECT
--   title, 
--   -- genres, # 기존에 array_exercises에 저장되어 있던 컬럼
--   genre
-- FROM advanced.array_exercises AS ae
-- CROSS JOIN UNNEST(genres) AS genre


-- 2) array_exercises 테이블에서 각 영화(title)별로 배우(actor)와 배역(character)을 보여주세요. 배우와 배역은 별도의 컬럼으로 나와야 합니다

SELECT
  -- title, actor, character
  title,
  actor.actor,
  actor.character
  -- actors, 
  # actors에 직접 접근하면 어떨까? => 새로운 컬럼으로 가능하나, 매번 SAFE_OFFSET을 지정해야 함
  # actors = [STRUCT, STRUCT]
  -- actors[SAFE_OFFSET(0)].actor AS first_actor,
  -- actors[SAFE_OFFSET(0)].character AS first_character,
  -- actors[SAFE_OFFSET(1)].actor AS second_actor,
  -- actors[SAFE_OFFSET(1)].character AS second_character,
  # 배열에 직접 접근이 아닌 UNNEST로 풀어야겠다!
FROM advanced.array_exercises AS ae
CROSS JOIN UNNEST(actors) AS actor


# 3) array_exercises 테이블에서 각 영화(title)별로 배우(actor), 배역(character), 장르(genre)를 출력하세요. 한 Row에 배우, 배역, 장르가 모두 표시되어야 합니다
SELECT
  title,
  -- actors, # ARRAY<STRUCT>
  actor.actor AS actor,
  actor.character AS character,
  -- genres # ARRAY<STRING>
  genre
  -- command + /, ctrl + /
FROM advanced.array_exercises, UNNEST(actors) AS actor, UNNEST(genres) AS genre
WHERE
  actor.actor = "Chris Evans"
  AND genre = "Action"
-- CROSS JOIN UNNEST(actors) AS actor
-- CROSS JOIN UNNEST(genres) AS genre

# 이 문제의 의도 : UNNEST를 2번 연속 사용할 수 있다. CROSS JOIN => JOIN 연속 2번과 맥락은 동일한데, UNNEST라는 것이 어색할 수 있었다
# 데이터의 중복이 어느정도 생기는데, 그것은 어쩔 수 없는 이슈(CROSS JOIN)
# No matching signature for operator = for argument types: STRUCT<actor STRING, character STRING>, STRING. Supported signature: ANY = ANY at [47:3]
# 오류 메시지 => 별도로 기록해서 모아두기!
# 실행 순서 : FROM -> JOIN -> SELECT
# actors : ARRAY<STRUCT> => UNNEST => STRUCT
# genres : ARRAY<STRING> => UNNEST => STRING

# TIP
# 같은 단어를 수정할 때, 빨리 하고 싶음 => 단어를 커서 위에 위치하고, ctrl + d / command + d 범위 설정하고 수정하면 일괄 수정

# 앱 로그 데이터 => UNNEST하기!
# 내가 직업 문제를 풀어보고 <-> 강사가 푼 결과
-- 왜 차이가 났을까? => 그 강사는 왜 그렇게 풀었고, 나는 이런 생각을 해서 이렇게 풀었다!
-- UNNEST => 데이터를 탐색해보세요. GROUP BY, 하루 사용자 집계, 어떤 이벤트가 있는가?


-- 4) 앱 로그 데이터(app_logs)의 배열을 풀어주세요

WITH base AS (
  SELECT
    event_date,
    event_timestamp,
    event_name,
    event_param.key AS key,
    -- event_param.value AS value,
    event_param.value.string_value AS string_value,
    event_param.value.int_value AS int_value,
    -- event_params,
    user_id
  FROM advanced.app_logs
  CROSS JOIN UNNEST(event_params) AS event_param
  WHERE
    event_date = "2022-08-01"
)
-- Syntax error: Expected end of input but got identifier "user_id" at [10:3]
-- 문법 오류 : 쉼표를 넣지 않아서 발생한 오류

-- Cannot access field value on a value with type ARRAY<STRUCT<key STRING, value STRUCT<string_value STRING, int_value INT64>>> at [10:16] => 이미 비슷한 오류를 봤음. UNNEST
-- 쿼리를 작성하는 과정에서 이런 오류를 보고, 어떻게 해석하는지도 아는 것이 매우 중요
-- 디버깅을 잘하는 노하우. 강의에서 의도적으로 오류를 내는 경우도 있고, 자연스럽게 발생하는 오류도 존재
-- ARRAY<STRUCT<key STRING, value STRUCT<string_value STRING, int_value INT64>>> => 어? 나는 ARRAY에 직접 접근한 적이 있나? 없지 않나? => 다시 쿼리를 봄

SELECT
  event_date, 
  event_name,
  COUNT(DISTINCT user_id) AS cnt
FROM base
GROUP BY ALL
ORDER BY cnt DESC
# 마지막 연습 문제 : 이 데이터를 직접 쿼리하면서 여러분들이 가설을 만들고, 그 가설에 대해 레포트를 작성해주세요!
