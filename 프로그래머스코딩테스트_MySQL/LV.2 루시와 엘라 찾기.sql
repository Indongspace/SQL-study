# 동물 보호소에 들어온 동물 중 이름이 Lucy, Ella, Pickle, Rogan, Sabrina, Mitty인 동물의 아이디와 이름, 성별 및 중성화 여부를 조회하는 SQL 문을 작성해주세요.
# 이때 결과는 아이디 순으로 조회해주세요. 
# 쿼리를 작성하는 목표, 확인할 지표 : 이름이 Lucy, Ella, Pickle, Rogan, Sabrina, Mitty인 동물의 정보 조회 / 아이디 순
# 쿼리 계산 방법 : WHERE NAME IN / ORDER BY
# 데이터의 기간 :
# 사용할 테이블 : ANIMAL_INS
# Join KEY :
# 데이터 특징 :

SELECT
    ANIMAL_ID,
    NAME,
    SEX_UPON_INTAKE
FROM ANIMAL_INS
WHERE 
    NAME IN ('Lucy', 'Ella', 'Pickle', 'Rogan', 'Sabrina', 'Mitty')
ORDER BY
    ANIMAL_ID