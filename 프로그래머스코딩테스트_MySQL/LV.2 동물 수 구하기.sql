# 동물 보호소에 동물이 몇 마리 들어왔는지 조회하는 SQL 문을 작성해주세요.
# 쿼리를 작성하는 목표, 확인할 지표 : 현재 몇 마리인지
# 쿼리 계산 방법 : COUNT
# 데이터의 기간 : 
# 사용할 테이블 : ANIMAL_ID
# Join KEY :
# 데이터 특징 :

SELECT
    COUNT(DISTINCT ANIMAL_ID) AS count
FROM ANIMAL_INS