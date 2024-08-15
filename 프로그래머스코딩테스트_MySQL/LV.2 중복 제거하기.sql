# 동물 보호소에 들어온 동물의 이름은 몇 개인지 조회하는 SQL 문을 작성해주세요. 
# 이때 이름이 NULL인 경우는 집계하지 않으며 중복되는 이름은 하나로 칩니다.
# 쿼리를 작성하는 목표, 확인할 지표 : 동물의 이름은 몇 개
# 쿼리 계산 방법 : WHERE IS NOT NULL / COUNT DISTINCT
# 데이터의 기간 :
# 사용할 테이블 : ANIMAL_INS
# Join KEY :
# 데이터 특징 :

SELECT
    COUNT(DISTINCT NAME) AS count
FROM ANIMAL_INS
WHERE
    NAME IS NOT NULL