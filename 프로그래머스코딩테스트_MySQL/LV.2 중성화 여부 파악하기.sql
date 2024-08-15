# 보호소의 동물이 중성화되었는지 아닌지 파악하려 합니다. 
# 중성화된 동물은 SEX_UPON_INTAKE 컬럼에 'Neutered' 또는 'Spayed'라는 단어가 들어있습니다. 
# 동물의 아이디와 이름, 중성화 여부를 아이디 순으로 조회하는 SQL문을 작성해주세요. 
# 이때 중성화가 되어있다면 'O', 아니라면 'X'라고 표시해주세요.
# 쿼리를 작성하는 목표, 확인할 지표 : 중성화 여부 파악 / 중성화 O 아니면 X / 아이디순 조회
# 쿼리 계산 방법 : CASE WHEN THEN / ORDER BY
# 데이터의 기간 :
# 사용할 테이블 : ANIMAL_INS
# Join KEY :
# 데이터 특징 :

SELECT
    ANIMAL_ID,
    NAME,
    CASE
        WHEN SEX_UPON_INTAKE LIKE '%Neutered%' THEN 'O'
        WHEN SEX_UPON_INTAKE LIKE '%Spayed%' THEN 'O'
        ELSE 'X'
        END AS 중성화
FROM ANIMAL_INS
ORDER BY
    ANIMAL_ID 
    