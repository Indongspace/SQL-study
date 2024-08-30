-- 1.  포켓몬의 'Speed'가 70 이상이면 '빠름', 그렇지 않으면 '느림'으로 표시하는 새로운 컬럼 'Speed_Category'를 만들어 주세요
# 쿼리를 작성하는 목표, 확인할 지표 : Speed 컬럼을 사용해 새로운 Speed_Category 만들어야 함
# 쿼리 계산 방법 : CASE WHEN, IF => 조건이 단일이다. IF. 70 이상
# 데이터의 기간 : X
# 사용할 테이블: pokemon
# Join KEY : X
# 데이터 특징 : MIN speed : 5. Max Speed : 140

SELECT
  -- *, # 모든 컬럼을 보여줘!
  id, 
  kor_name,
  speed,
  IF(speed >= 70, "빠름", "느림") AS Speed_Category
FROM basic.pokemon


-- 2. 포켓몬의 'type1'에 따라 'Water', 'Fire', 'Electric' 타입은 각각 '물', '불', '전기'로, 그 외 타입은 '기타'로 분류하는 새로운 컬럼 'type_Korean'을 만들어 주세요
# 쿼리를 작성하는 목표, 확인할 지표 : type1을 사용해서 특정 조건을 만족하는 것은 값을 변경, 기타 => type_Korean
# 쿼리 계산 방법 : CASE WHEN, IF => 여러 조건이 있음. Water => 물, Fire => 불, Electric => 전기. CASE WHEN
# 데이터의 기간 : X
# 사용할 테이블: pokemon
# Join KEY : X
# 데이터 특징 : 타입이 여러가지가 있다.  

SELECT
  id,
  kor_name,
  type1,
  CASE
    WHEN type1 = "Water" THEN "물"
    WHEN type1 = "Fire" THEN "불"
    WHEN type1 = "Electric" THEN "전기"
    ELSE "기타"
  END AS type1_Korean
FROM basic.pokemon

-- 3. 각 포켓몬의 총점(total)을 기준으로, 300 이하면 'Low', 301에서 500 사이면 'Medium', 501 이상이면 'High'로 분류해주세요
# 쿼리를 작성하는 목표, 확인할 지표 : total 컬럼 => 조건에 맞는 값을 변경! 모두 다 숫자!
# 쿼리 계산 방법 : CASE WHEN
# 데이터의 기간 : X
# 사용할 테이블: pokemon
# Join KEY : X
# 데이터 특징 : total 컬럼이 정수(INTEGER) 

SELECT
  id,
  kor_name,
  total,
  CASE
    WHEN total >= 501 THEN "High"
    WHEN total BETWEEN 300 AND 500 THEN "Medium"
  ELSE "Low"
  END AS total_grade
FROM basic.pokemon
-- WHERE
  -- total_grade = "Low"
  -- Unrecognized name: total_grade. 컬럼의 이름을 인지할 수 없다. 컬럼이 없다

-- 4. 각 트레이너의 배지 개수(badge_count)를 기준으로, 5개 이하면 'Beginner', 6개에서 8개 사이면 'Intermediate', 그 이상이면 'Advanced'로 분류해주세요.
# 쿼리를 작성하는 목표, 확인할 지표 : badge_count => 조건에 만족하는 값을 변경
# 쿼리 계산 방법 : CASE WHEN
# 데이터의 기간 : X
# 사용할 테이블: trainer
# Join KEY : X
# 데이터 특징 : X

SELECT
  id,
  name,
  badge_count,
  CASE
    WHEN badge_count >= 9 THEN "Advanced"
    WHEN badge_count BETWEEN 6 AND 8 THEN "Intermediate"
  ELSE "Beginner"
  END AS trainer_level
FROM basic.trainer

-- 5.  트레이너가 포켓몬을 포획한 날짜(catch_date)가 '2023-01-01' 이후이면 'Recent', 그렇지 않으면 'Old'로 분류해주세요.
# 쿼리를 작성하는 목표, 확인할 지표 : 포획한 날짜 기준으로 값을 변경!
# 쿼리 계산 방법 : IF
# 데이터의 기간 : X
# 사용할 테이블: trainer_pokemon
# Join KEY : X
# 데이터 특징 : catch_date는 UTC 기준. catch_datetime은 TIMESTAMP

SELECT
  id,
  trainer_id,
  pokemon_id,
  catch_datetime,
  IF(DATE(catch_datetime, "Asia/Seoul") > "2023-01-01", "Recent", "Old") AS recent_or_old,
  # 빨간색 ( 또는 )는 짝을 못 찾았다. 열었으면 닫아야 한다
  -- 모든 조건이 A로 변환한다
  -- "Recent" AS recent_value # 모든 컬럼에 동일한 값을 추가하고 싶을 때는 이렇게 문자를 바로 작성해도 된다
FROM basic.trainer_pokemon

-- 6. 배틀에서 승자(winner_id)가 player1_id와 같으면 'Player 1 Wins', player2_id와 같으면 'Player 2 Wins', 그렇지 않으면 'Draw'로 결과가 나오게 해주세요
# 쿼리를 작성하는 목표, 확인할 지표 : 승패 여부를 알 수 있는 컬럼을 만들고 싶다!
# 쿼리 계산 방법 : CASE WHEN
# 데이터의 기간 : X
# 사용할 테이블: battle
# Join KEY : X
# 데이터 특징 : X 

SELECT
  id,
  winner_id,
  player1_id,
  player2_id,
  CASE 
    WHEN winner_id = player1_id THEN "Player 1 Wins"
    WHEN winner_id = player2_id THEN "Player 2 Wins"
    -- Unrecognized name: palyer2_id; Did you mean player2_id?
  ELSE "Draw"
  END AS battle_result
FROM basic.battle
