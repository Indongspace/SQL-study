# 동물의 생물 종, 이름, 성별 및 중성화 여부를 아이디 순으로 조회하는 SQL문을 작성해주세요. 
# 이때 프로그래밍을 모르는 사람들은 NULL이라는 기호를 모르기 때문에, 이름이 없는 동물의 이름은 "No name"으로 표시해 주세요.
# 쿼리를 작성하는 목표, 확인할 지표 : 종,이름,성별및중성화여부 / 아이디 순 / null은 no name 대체
# 쿼리 계산 방법 : ORDER BY ANIMAL_ID / COALESCE
# 데이터의 기간 : 
# 사용할 테이블 : ANIMAL_INS
# Join KEY :
# 데이터 특징 :

SELECT
    ANIMAL_TYPE,
    COALESCE(NAME, 'No name') AS NAME,
    SEX_UPON_INTAKE
FROM ANIMAL_INS
ORDER BY
    ANIMAL_ID
    