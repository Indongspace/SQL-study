# 동물 보호소에 들어온 동물 이름 중, 이름에 "EL"이 들어가는 개의 아이디와 이름을 조회하는 SQL문을 작성해주세요. 
# 이때 결과는 이름 순으로 조회해주세요. 단, 이름의 대소문자는 구분하지 않습니다.
# 쿼리를 작성하는 목표, 확인할 지표 : 이름에 EL이 들어가는 아이디,이름 / 개 / 이름 순으로
# 쿼리 계산 방법 : WHERE ANIMAL_TYPE / LIKE '%EL%' / ORDER BY
# 데이터의 기간 :
# 사용할 테이블 : ANIMAL_INS
# Join KEY :
# 데이터 특징 :

SELECT
    ANIMAL_ID,
    NAME
FROM ANIMAL_INS
WHERE
    ANIMAL_TYPE = 'Dog' AND
    NAME LIKE '%EL%'
ORDER BY
    NAME