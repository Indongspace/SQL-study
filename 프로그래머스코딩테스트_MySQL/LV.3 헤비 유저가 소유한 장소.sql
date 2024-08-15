# PLACES 테이블은 공간 임대 서비스에 등록된 공간의 정보를 담은 테이블입니다. PLACES 테이블의 구조는 다음과 같으며 ID, NAME, HOST_ID는 각각 공간의 아이디, 이름, 공간을 소유한 유저의 아이디를 나타냅니다. ID는 기본키입니다.

# 이 서비스에서는 공간을 둘 이상 등록한 사람을 "헤비 유저"라고 부릅니다. 
# 헤비 유저가 등록한 공간의 정보를 아이디 순으로 조회하는 SQL문을 작성해주세요.
# 쿼리를 작성하는 목표, 확인할 지표 : 둘 이상 등록한 사람(HOST_ID 중복) 정보 출력
# 쿼리 계산 방법 : WITH, GROUP BY, ORDER BY
# 데이터의 기간 :
# 사용할 테이블 : PLACES
# Join KEY :
# 데이터 특징 :
WITH HEAVY AS (
SELECT
    *,
    COUNT(HOST_ID) AS COUNTY
FROM PLACES
GROUP BY
    HOST_ID
HAVING
    COUNTY > 1
)

SELECT
    *
FROM PLACES
WHERE
    HOST_ID IN (SELECT HOST_ID FROM HEAVY)
ORDER BY
    ID
#