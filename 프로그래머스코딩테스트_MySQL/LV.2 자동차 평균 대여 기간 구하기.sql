# CAR_RENTAL_COMPANY_RENTAL_HISTORY 테이블에서 평균 대여 기간이 7일 이상인 자동차들의 자동차 ID와 평균 대여 기간(컬럼명: AVERAGE_DURATION) 리스트를 출력하는 SQL문을 작성해주세요. 
# 평균 대여 기간은 소수점 두번째 자리에서 반올림하고, 결과는 평균 대여 기간을 기준으로 내림차순 정렬해주시고, 평균 대여 기간이 같으면 자동차 ID를 기준으로 내림차순 정렬해주세요.

# 쿼리를 작성하는 목표, 확인할 지표 : 평균 대여기간이 7일 이상인 자동차의 ID 와 평균 대여기간 리스트 출력
# 쿼리 계산 방법 : DATEDIFF / AVG / HAVING / GROUP BY / ROUND / ORDER BY
# 데이터의 기간 :
# 사용할 테이블 : CAR_RENTAL_COMPANY_RENTAL_HISTORY
# Join KEY :
# 데이터 특징 :
    
SELECT
    CAR_ID,
    ROUND(AVG(DATEDIFF(END_DATE, START_DATE)+1),1) AS AVERAGE_DURATION
FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY
GROUP BY
    CAR_ID
HAVING
    AVERAGE_DURATION >= 7
ORDER BY 
    AVERAGE_DURATION DESC,
    CAR_ID DESC