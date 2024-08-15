# 월별 잡은 물고기의 수와 월을 출력하는 SQL문을 작성해주세요.
# 잡은 물고기 수 컬럼명은 FISH_COUNT, 월 컬럼명은 MONTH로 해주세요.
# 결과는 월을 기준으로 오름차순 정렬해주세요.
# 단, 월은 숫자형태 (1~12) 로 출력하며 9 이하의 숫자는 두 자리로 출력하지 않습니다. 잡은 물고기가 없는 월은 출력하지 않습니다.
# 쿼리를 작성하는 목표, 확인할 지표 : 월별로 잡은 물고기 수와 월 출력, 오름차순, TIME
# 쿼리 계산 방법 : GROUP BY MONTH, COUNT, ORDER BY
# 데이터의 기간 : MONTH
# 사용할 테이블 : FISH_INFO
# Join KEY :
# 데이터 특징 :

SELECT
    COUNT(ID) AS FISH_COUNT,
    MONTH(TIME) AS MONTH
FROM FISH_INFO
GROUP BY
    MONTH(TIME)
ORDER BY
    MONTH(TIME) ASC
    