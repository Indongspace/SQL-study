# FISH_INFO 테이블에서 잡은 BASS와 SNAPPER의 수를 출력하는 SQL 문을 작성해주세요.
# 컬럼명은 'FISH_COUNT`로 해주세요.
# 쿼리를 작성하는 목표, 확인할 지표 : BASS와 SNAPPER 수 출력, FISH_TYPE 0 1
# 쿼리 계산 방법 : WHERE 
# 데이터의 기간 :
# 사용할 테이블 : FISH_INFO, FISH_NAME_INFO
# Join KEY : FISH_TYPE
# 데이터의 특징 :

SELECT
    COUNT(INFO.ID) AS FISH_COUNT    
FROM FISH_INFO AS INFO
LEFT JOIN FISH_NAME_INFO AS NAME
ON INFO.FISH_TYPE = NAME.FISH_TYPE
WHERE
    NAME.FISH_NAME IN ('BASS', 'SNAPPER')
    