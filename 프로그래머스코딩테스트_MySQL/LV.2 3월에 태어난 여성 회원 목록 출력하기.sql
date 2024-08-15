# MEMBER_PROFILE 테이블에서 생일이 3월인 여성 회원의 ID, 이름, 성별, 생년월일을 조회하는 SQL문을 작성해주세요. 
# 이때 전화번호가 NULL인 경우는 출력대상에서 제외시켜 주시고, 결과는 회원ID를 기준으로 오름차순 정렬해주세요.
# 쿼리를 작성하는 목표, 확인할 지표 : 여성 & NULL 제외 & 생일이 3월 / ID기준 오름차순
# 쿼리 계산 방법 : WHERE W & IS NOT NULL & M = 3 / ORDER BY
# 데이터의 기간 : 3월
# 사용할 테이블 : MEMBER_PROFILE
# Join KEY :
# 데이터 특징 :

SELECT
    MEMBER_ID,
    MEMBER_NAME,
    GENDER,
    DATE_FORMAT(DATE_OF_BIRTH, '%Y-%m-%d') AS DATE_OF_BIRTH
FROM MEMBER_PROFILE
WHERE
    GENDER = 'W' AND
    TLNO IS NOT NULL AND
    DATE_FORMAT(DATE_OF_BIRTH, '%m') = 3
ORDER BY
    MEMBER_ID ASC
    