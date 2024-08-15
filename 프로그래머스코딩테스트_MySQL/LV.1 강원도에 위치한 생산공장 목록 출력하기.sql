-- 강원도에 위치한 식품공장의 공장 ID, 공장 이름, 주소를 조회하는 SQL문을 작성해주세요. 
-- 이때 결과는 공장 ID를 기준으로 오름차순 정렬해주세요.
# 쿼리를 작성하는 목표, 확인할 지표 : 강원도에 위치한 식품공장 정보 조회 / ADDRESS 
# 쿼리 계산 방법 : ADDRESS IN '강원도'
# 데이터의 기간 : 
# 사용할 테이블 : FOOD_FACTORY
# Join KEY :
# 데이터의 특징

SELECT
    FACTORY_ID,
    FACTORY_NAME,
    ADDRESS
FROM FOOD_FACTORY
WHERE 
    ADDRESS LIKE '%강원도%'
-- 프로그래머스 코딩테스트 사이트에서 제공하는 테이블이라 여기서는 실행 불가
