# 낚시앱에서 사용하는 FISH_INFO 테이블은 잡은 물고기들의 정보를 담고 있습니다. FISH_INFO 테이블의 구조는 다음과 같으며 ID, FISH_TYPE, LENGTH, TIME은 각각 잡은 물고기의 ID, 물고기의 종류(숫자), 잡은 물고기의 길이(cm), 물고기를 잡은 날짜를 나타냅니다.

# 단, 잡은 물고기의 길이가 10cm 이하일 경우에는 LENGTH 가 NULL 이며, LENGTH 에 NULL 만 있는 경우는 없습니다.

# FISH_NAME_INFO 테이블은 물고기의 이름에 대한 정보를 담고 있습니다. FISH_NAME_INFO 테이블의 구조는 다음과 같으며, FISH_TYPE, FISH_NAME 은 각각 물고기의 종류(숫자), 물고기의 이름(문자) 입니다.

# 문제
# 물고기 종류 별로 가장 큰 물고기의 ID, 물고기 이름, 길이를 출력하는 SQL 문을 작성해주세요.

# 물고기의 ID 컬럼명은 ID, 이름 컬럼명은 FISH_NAME, 길이 컬럼명은 LENGTH로 해주세요.
# 결과는 물고기의 ID에 대해 오름차순 정렬해주세요.
# 단, 물고기 종류별 가장 큰 물고기는 1마리만 있으며 10cm 이하의 물고기가 가장 큰 경우는 없습니다.

# 쿼리를 작성하는 목표, 확인할 지표 : 물고기 종류 별로 가장 큰 물고기 정보 출력 / FISH_TYPE, LENGTH
# 쿼리 계산 방법 : WITH, GROUP BY, MAX, JOIN, ORDER BY 
# 데이터의 기간 :
# 사용할 테이블 : FISH_INFO, FISH_NAME_INFO 
# Join KEY : FISH_TYPE
# 데이터 특징 :
WITH BASE AS (
    SELECT
        INFO.ID,
        INFO.FISH_TYPE,
        NAME.FISH_NAME,
        INFO.LENGTH
    FROM FISH_INFO AS INFO
    INNER JOIN FISH_NAME_INFO AS NAME
    ON INFO.FISH_TYPE = NAME.FISH_TYPE
), MAX_LEN AS (
    SELECT
        FISH_TYPE,
        MAX(LENGTH) AS LENGTH
    FROM FISH_INFO
    GROUP BY
        FISH_TYPE
) 
SELECT
    BASE.ID,
    BASE.FISH_NAME,
    BASE.LENGTH
FROM BASE
INNER JOIN MAX_LEN
ON BASE.FISH_TYPE = MAX_LEN.FISH_TYPE
WHERE
    BASE.LENGTH = MAX_LEN.LENGTH
ORDER BY
    BASE.ID ASC
    