# FISH_NAME_INFO에서 물고기의 종류 별 물고기의 이름과 잡은 수를 출력하는 SQL문을 작성해주세요.
# 물고기의 이름 컬럼명은 FISH_NAME, 잡은 수 컬럼명은 FISH_COUNT로 해주세요.
# 결과는 잡은 수 기준으로 내림차순 정렬해주세요.  
# 쿼리를 작성하는 목표, 확인할 지표 : 물고기 종류 별 이름과 잡은 수 출력, 내림차순
# 쿼리 계산 방법 : JOIN, GROUP BY, COUNT, ORDER BY
# 데이터의 기간 :
# 사용할 테이블 : FISH_INFO, FISH_NAME_INFO
# Join KEY : FISH_TYPE
# 데이터 특징 :

SELECT
    COUNT(INFO.ID) AS FISH_COUNT,
    NAME.FISH_NAME AS FISH_NAME
FROM FISH_INFO AS INFO
LEFT JOIN FISH_NAME_INFO AS NAME
ON INFO.FISH_TYPE = NAME.FISH_TYPE
GROUP BY
    NAME.FISH_NAME
ORDER BY
    FISH_COUNT DESC