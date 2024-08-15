-- USER_INFO 테이블에서 2021년에 가입한 회원 중 나이가 20세 이상 29세 이하인 회원이 몇 명인지 출력하는 SQL문을 작성해주세요.
# 쿼리를 작성하는 목표, 확인할 지표 : 20세이상 29세 이하 회원 수, AGE / USER_ID
# 쿼리 계산 방법 : WHERE AGE >= 20 AND AGE <= 29 / COUNT(USER_ID) / JOINED 2021
# 데이터의 기간 :
# 사용할 테이블 : USER_INFO
# Join KEY :
# 데이터의 특징 :

SELECT
    COUNT(DISTINCT USER_ID) AS USERS
FROM USER_INFO
WHERE
    JOINED BETWEEN '2021-01-01' AND '2021-12-31'
    AND AGE >= 20 
    AND AGE <= 29
    