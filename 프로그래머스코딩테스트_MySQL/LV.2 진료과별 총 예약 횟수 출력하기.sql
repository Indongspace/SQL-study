# APPOINTMENT 테이블에서 2022년 5월에 예약한 환자 수를 진료과코드 별로 조회하는 SQL문을 작성해주세요. 
# 이때, 컬럼명은 '진료과 코드', '5월예약건수'로 지정해주시고 
# 결과는 진료과별 예약한 환자 수를 기준으로 오름차순 정렬하고, 예약한 환자 수가 같다면 진료과 코드를 기준으로 오름차순 정렬해주세요.
# 쿼리를 작성하는 목표, 확인할 지표 : 2022년 5월에 예약한 환자, APNT_YMD, APNT_CNCL_YN
# 쿼리 계산 방법 : WHERE / GROUP BY / COUNT / ORDER BY
# 데이터의 기간 : 2022년 5월
# 사용할 테이블 : APPOINTMENT
# Join KEY :
# 데이터 특징 :

SELECT
    MCDP_CD AS 진료과코드, 
    COUNT(PT_NO) AS 5월예약건수
FROM APPOINTMENT
WHERE
    DATE_FORMAT(APNT_YMD, "%Y-%m") = '2022-05' 
    #AND APNT_CNCL_YN != 'Y'
GROUP BY
    MCDP_CD
ORDER BY
    5월예약건수 ASC,
    진료과코드 ASC
    