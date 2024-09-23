# 낚시앱에서 사용하는 FISH_INFO 테이블은 잡은 물고기들의 정보를 담고 있습니다. FISH_INFO 테이블의 구조는 다음과 같으며 ID, FISH_TYPE, LENGTH, TIME은 각각 잡은 물고기의 ID, 물고기의 종류(숫자), 잡은 물고기의 길이(cm), 물고기를 잡은 날짜를 나타냅니다.

# 문제
# FISH_INFO에서 평균 길이가 33cm 이상인 물고기들을 종류별로 분류하여 잡은 수, 최대 길이, 물고기의 종류를 출력하는 SQL문을 작성해주세요. 결과는 물고기 종류에 대해 오름차순으로 정렬해주시고, 10cm이하의 물고기들은 10cm로 취급하여 평균 길이를 구해주세요.

# 컬럼명은 물고기의 종류 'FISH_TYPE', 잡은 수 'FISH_COUNT', 최대 길이 'MAX_LENGTH'로 해주세요.

# 쿼리를 작성하는 목표, 확인할 지표 : NULL을 10으로 대체 평균길이구하고, 33이상인 물고기의 잡은 수, 최대길이, 종류 출력 / LENGTH, FISH_TYPE, COUNT
# 쿼리 계산 방법 : IFNULL -> GROUP BY AVG -> HAVING >= 33 -> JOIN -> COUNT, MAX 
# 데이터의 기간 :
# 사용할 테이블 : FISH_INFO
# Join KEY :
# 데이터 특징 :
WITH BASE AS (
    SELECT
        FISH_TYPE,
        AVG(LENGTH) AS AVG_LEN
    FROM (
        SELECT
            ID,
            FISH_TYPE,
            IFNULL(LENGTH, 10) AS LENGTH
        FROM FISH_INFO
    ) AS AVG_INFO
    GROUP BY
        FISH_TYPE
    HAVING
        AVG_LEN >= 33
)   

SELECT
    *
FROM FISH_INFO AS INFO
JOIN BASE 
ON INFO.FISH_TYPE = BASE.FISH_TYPE
    