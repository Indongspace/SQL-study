-- PATIENT 테이블에서 12세 이하인 여자환자의 환자이름, 환자번호, 성별코드, 나이, 전화번호를 조회하는 SQL문을 작성해주세요. 
-- 이때 전화번호가 없는 경우, 'NONE'으로 출력시켜 주시고 결과는 나이를 기준으로 내림차순 정렬하고, 나이 같다면 환자이름을 기준으로 오름차순 정렬해주세요.
# 쿼리를 작성하는 목표, 확인할 지표 : 12세 이하 / 전화번호 없으면 NONE / 나이기준 내림차순 / 환자이름기준 오름차순
# 쿼리 계산 방법 : WHERE AGE <= 12 / COALESCE NONE / ORDER BY DESC / ORDER BY ASC
# 데이터의 기간 :
# 사용할 테이블 : PATIENT
# Join KEY :
# 데이터 특징 :

SELECT
    PT_NAME,
    PT_NO,
    GEND_CD,
    AGE,
    COALESCE(TLNO, 'NONE') AS TLNO
FROM PATIENT
WHERE
    AGE <= 12 AND
    GEND_CD = 'W'
ORDER BY
    AGE DESC,
    PT_NAME ASC