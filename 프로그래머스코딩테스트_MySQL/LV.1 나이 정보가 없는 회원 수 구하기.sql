-- USER_INFO 테이블에서 나이 정보가 없는 회원이 몇 명인지 출력하는 SQL문을 작성해주세요. 
-- 이때 컬럼명은 USERS로 지정해주세요.
# 쿼리를 작성하는 목표, 확인할 지표 : AGE가 NULL인 회원이 몇 명인지
# 쿼리 계산 방법 :
# 데이터의 기간 :
# 사용할 테이블 : USER_INFO
# Join KEY :
# 데이터 특징 :

SELECT
    COUNT(DISTINCT USER_ID) AS USERS
FROM USER_INFO
WHERE
    AGE IS NULL