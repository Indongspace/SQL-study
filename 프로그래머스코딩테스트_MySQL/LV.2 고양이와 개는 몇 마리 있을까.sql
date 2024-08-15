# 동물 보호소에 들어온 동물 중 고양이와 개가 각각 몇 마리인지 조회하는 SQL문을 작성해주세요. 
# 이때 고양이를 개보다 먼저 조회해주세요.
# 쿼리를 작성하는 목표, 확인할 지표 : 고양이와 개가 각각 몇 마리인지 / 고양이를 먼저 조회
# 쿼리 계산 방법 : 종류가 고양이와 개밖에 없다면 바로 GROUP BY, 아니라면 WHERE IN 먼저 / ORDER BY ASC 하면 CAT 먼저 나옴
# 데이터의 기간 : 
# 사용할 테이블 : ANIMAL_INS
# Join KEY :
# 데이터 특징 :

SELECT
    ANIMAL_TYPE,
    COUNT(ANIMAL_ID) AS count
FROM ANIMAL_INS
GROUP BY
    ANIMAL_TYPE
ORDER BY
    ANIMAL_TYPE ASC
    