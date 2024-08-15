-- FISH_INFO 테이블에서 잡은 물고기 중 가장 큰 물고기의 길이를 'cm' 를 붙여 출력하는 SQL 문을 작성해주세요.
-- 이 때 컬럼명은 'MAX_LENGTH' 로 지정해주세요.
# 쿼리를 작성하는 목표, 확인할 지표 : 가장 큰 물고기의 길이/ cm 붙여
# 쿼리 계산 방법 : MAX / CONCAT 'cm'
# 데이터의 기간 :
# 사용할 테이블 : FISH_INFO
# Join KEY : 
# 데이터 특징 :

SELECT
    CONCAT(MAX(LENGTH), 'cm') AS MAX_LENGTH
FROM FISH_INFO
