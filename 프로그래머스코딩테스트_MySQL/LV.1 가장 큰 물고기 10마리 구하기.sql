# FISH_INFO 테이블에서 가장 큰 물고기 10마리의 ID와 길이를 출력하는 SQL 문을 작성해주세요. 결과는 길이를 기준으로 내림차순 정렬하고, 길이가 같다면 물고기의 ID에 대해 오름차순 정렬해주세요. 단, 가장 큰 물고기 10마리 중 길이가 10cm 이하인 경우는 없습니다.
# ID 컬럼명은 ID, 길이 컬럼명은 LENGTH로 해주세요.
# 쿼리를 작성하는 목표, 확인할 지표 : 길이 가장 큰 물고기 10마리 / 길이 내림차순 / ID 오름차순
# 쿼리 계산 방법 : ORDER BY DESC LIMIT 10 / ID ASC
# 데이터의 기간 :
# 사용할 테이블 : FISH_INFO
# Join KEY :
# 데이터 특징 :

SELECT
    ID,
    LENGTH
FROM FISH_INFO
ORDER BY
    LENGTH DESC,
    ID ASC
LIMIT 10
