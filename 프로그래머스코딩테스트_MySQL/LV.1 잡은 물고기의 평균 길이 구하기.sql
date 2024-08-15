# 문제
# 잡은 물고기의 평균 길이를 출력하는 SQL문을 작성해주세요.
# 평균 길이를 나타내는 컬럼 명은 AVERAGE_LENGTH로 해주세요.
# 평균 길이는 소수점 3째자리에서 반올림하며, 10cm 이하의 물고기들은 10cm 로 취급하여 평균 길이를 구해주세요.
# 쿼리를 작성하는 목표, 확인할 지표 : 물고기의 평균 길이/ 소수점 3째자리 반올림/ NULL이면 10CM
# 쿼리 계산 방법 : AVG / ROUND(, 2) / COALESCE
# 데이터의 기간 :
# 사용할 테이블 : FISH_INFO
# Join KEY : 
# 데이터 특징 :

SELECT
    ROUND(AVG(COALESCE(LENGTH, 10)),2) AS AVERAGE_LENGTH
FROM FISH_INFO;