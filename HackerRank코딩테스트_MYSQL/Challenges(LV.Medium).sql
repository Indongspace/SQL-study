-- Julia asked her students to create some coding challenges. Write a query to print the hacker_id, name, and the total number of challenges created by each student. Sort your results by the total number of challenges in descending order. If more than one student created the same number of challenges, then sort the result by hacker_id. If more than one student created the same number of challenges and the count is less than the maximum number of challenges created, then exclude those students from the result.
-- Input Format
-- The following tables contain challenge data:
-- Hackers: The hacker_id is the id of the hacker, and name is the name of the hacker.
-- Challenges: The challenge_id is the id of the challenge, and hacker_id is the id of the student who created the challenge.

-- Sample Output 0
-- 21283 Angela 6
-- 88255 Patrick 5
-- 96196 Lisa 1

-- Sample Output 1
-- 12299 Rose 6
-- 34856 Angela 6
-- 79345 Frank 4
-- 80491 Patrick 3
-- 81041 Lisa 1

-- Explanation
-- For Sample Case 0, we can get the following details:
-- Students 5077 and 62743 both created 4 challenges, but the maximum number of challenges created is 6 so these students are excluded from the result.
-- For Sample Case 1, we can get the following details:
-- Students 12299 and 34856 both created 6 challenges. Because 6 is the maximum number of challenges created, these students are included in the result.

-- 줄리아는 학생들에게 코딩 챌린지를 만드는 과제를 부여했습니다. 각 학생이 만든 챌린지의 총 개수를 출력하는 쿼리를 작성하세요. 결과는 챌린지의 총 개수를 기준으로 내림차순으로 정렬하세요. 만약 여러 학생이 같은 수의 챌린지를 만들었다면, hacker_id를 기준으로 정렬하세요. 또한, 여러 학생이 같은 수의 챌린지를 만들었고 그 수가 가장 많은 챌린지 개수보다 적다면, 해당 학생들은 결과에서 제외하세요.
-- 입력 형식
-- 다음 테이블에는 챌린지 데이터가 포함되어 있습니다:
-- Hackers: hacker_id는 해커의 ID이며, name은 해커의 이름입니다.
-- Challenges: challenge_id는 챌린지의 ID이며, hacker_id는 챌린지를 만든 학생의 ID입니다.

-- 샘플 출력 0
-- 21283 Angela 6
-- 88255 Patrick 5
-- 96196 Lisa 1

-- 샘플 출력 1
-- 12299 Rose 6
-- 34856 Angela 6
-- 79345 Frank 4
-- 80491 Patrick 3
-- 81041 Lisa 1

-- 설명
-- 샘플 케이스 0의 경우, 다음과 같은 세부 정보를 얻을 수 있습니다:
-- 학생 5077과 62743은 각각 4개의 챌린지를 만들었지만, 가장 많은 챌린지 개수가 6이기 때문에 이 학생들은 결과에서 제외됩니다.
-- 샘플 케이스 1의 경우, 다음과 같은 세부 정보를 얻을 수 있습니다:
-- 학생 12299와 34856은 각각 6개의 챌린지를 만들었습니다. 6은 가장 많은 챌린지 개수이기 때문에 이 학생들은 결과에 포함됩니다.

# 쿼리를 작성하는 목표, 확인할 지표 : 각 학생이 만든 챌린지의 총 개수 출력 / COUNT(CHALLENGE_ID)
# 쿼리 계산 방법 : 1. 해커 ID 별 챌린지의 개수 COUNT -> 
# 2. 해커 ID 별 챌린지의 개수의 MAX 값 ->
# 3. NAME을 추출하기 위해 HACKERS테이블 INNER JOIN -> 
# 4. 챌린지 개수 별 GROUP BY 후 HAVING 조건으로, 만든 챌린지 갯수가 똑같은 사람들을 거르거나 OR 
# 거르지 않고 포함시킨다면 해커들이 만든 챌린지 갯수 중 가장 많이 만든 갯수의 값과 일치하거나 많아야 함 -> 
# 5. 정렬
# 데이터의 기간 :
# 사용할 테이블 : HACKERS, CHALLENGES 
# Join KEY : HACKER_ID
# 데이터 특징 :
WITH CHALLENGE_CNT AS (
    # 1. 해커 ID 별 챌린지의 개수 COUNT
    SELECT
        HACKER_ID,
        COUNT(CHALLENGE_ID) AS CNT
    FROM CHALLENGES
    GROUP BY
        HACKER_ID
), MAX_CNT AS (
    # 2. 해커 ID 별 챌린지의 개수의 MAX 값
    SELECT
        MAX(CNT) AS MAX_CNT
    FROM CHALLENGE_CNT
)
SELECT
    C.HACKER_ID,
    H.NAME,
    C.CNT
FROM CHALLENGE_CNT AS C
# 3. NAME을 추출하기 위해 HACKERS테이블 INNER JOIN
INNER JOIN HACKERS AS H
ON C.HACKER_ID = H.HACKER_ID
WHERE 
	# 4. 챌린지 개수 별 GROUP BY 후 HAVING 조건으로, 만든 챌린지 갯수가 똑같은 사람들을 거르거나
    # 거르지 않고 포함시킨다면 해커들이 만든 챌린지 갯수 중 가장 많이 만든 갯수의 값과 일치하거나 많아야 함
    C.CNT NOT IN (SELECT CNT FROM CHALLENGE_CNT GROUP BY CNT HAVING COUNT(*) > 1) OR
    C.CNT >= (SELECT MAX_CNT FROM MAX_CNT)
# 5. 정렬
ORDER BY
    CNT DESC,
    HACKER_ID ASC