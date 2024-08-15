# ANIMAL_INS 테이블에 등록된 모든 레코드에 대해, 각 동물의 아이디와 이름, 들어온 날짜1를 조회하는 SQL문을 작성해주세요. 
# 이때 결과는 아이디 순으로 조회해야 합니다.
# 시각(시-분-초)을 제외한 날짜(년-월-일)만 보여주세요
# 쿼리를 작성하는 목표, 확인할 지표 : 모든 정보 조회 / 시간 정보 제외 / 아이디 순 조회
# 쿼리 계산 방법 : DATE / ORDER BY
# 데이터의 기간 : 
# 사용할 테이블 : ANIMAL_INS
# Join KEY :
# 데이터 특징 :

SELECT
    ANIMAL_ID,
    NAME,
    DATE_FORMAT(DATETIME, '%Y-%m-%d') AS 날짜
FROM ANIMAL_INS
ORDER BY
    ANIMAL_ID
    
    