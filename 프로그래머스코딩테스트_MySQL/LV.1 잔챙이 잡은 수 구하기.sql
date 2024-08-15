-- 잡은 물고기 중 길이가 10cm 이하인 물고기의 수를 출력하는 SQL 문을 작성해주세요.
-- 물고기의 수를 나타내는 컬럼 명은 FISH_COUNT로 해주세요.
# 쿼리를 작성하는 목표, 확인할 지표 : 길이 10CM이하 물고기 수 
# 쿼리 계산 방법 : WHERE / COUNT
# 데이터의 기간 :
# 사용할 테이블 : FISH_INFO
# Join KEY :
# 데이터 특징 :

# SELECT
#     COUNT(ID) AS FISH_COUNT
# FROM FISH_INFO
# WHERE
#     LENGTH IS NULL

# 다른풀이
SELECT
    COUNT(
        CASE
            WHEN LENGTH IS NULL THEN 1 
    END) AS FISH_COUNT
FROM FISH_INFO