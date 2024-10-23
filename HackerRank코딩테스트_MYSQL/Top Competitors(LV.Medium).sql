-- Julia just finished conducting a coding contest, and she needs your help assembling the leaderboard! 
-- Write a query to print the respective hacker_id and name of hackers who achieved full scores for more than one challenge. 
-- Order your output in descending order by the total number of challenges in which the hacker earned a full score. If more than one hacker received full scores in same number of challenges, then sort them by ascending hacker_id.
-- Input Format
-- The following tables contain contest data:
-- Hackers: The hacker_id is the id of the hacker, and name is the name of the hacker.
-- Difficulty: The difficult_level is the level of difficulty of the challenge, and score is the score of the challenge for the difficulty level.
-- Challenges: The challenge_id is the id of the challenge, the hacker_id is the id of the hacker who created the challenge, and difficulty_level is the level of difficulty of the challenge.
-- Submissions: The submission_id is the id of the submission, hacker_id is the id of the hacker who made the submission, challenge_id is the id of the challenge that the submission belongs to, and score is the score of the submission.

-- Sample Output
-- 90411 Joe

-- Explanation
-- Hacker 86870 got a score of 30 for challenge 71055 with a difficulty level of 2, so 86870 earned a full score for this challenge.
-- Hacker 90411 got a score of 30 for challenge 71055 with a difficulty level of 2, so 90411 earned a full score for this challenge.
-- Hacker 90411 got a score of 100 for challenge 66730 with a difficulty level of 6, so 90411 earned a full score for this challenge.
-- Only hacker 90411 managed to earn a full score for more than one challenge, so we print the their hacker_id and name as 2 space-separated values.

-- 줄리아는 코딩 대회를 마쳤고, 리더보드를 작성하는 데 도움을 필요로 합니다! 여러 챌린지에서 만점을 받은 해커의 hacker_id와 이름을 출력하는 쿼리를 작성하세요. 
-- 출력은 해커가 만점을 받은 챌린지의 총 개수를 기준으로 내림차순으로 정렬해야 합니다. 여러 해커가 동일한 수의 챌린지에서 만점을 받은 경우 hacker_id를 기준으로 오름차순으로 정렬하세요.
-- 입력 형식
-- 다음 표들은 대회의 데이터를 포함하고 있습니다:
-- Hackers: hacker_id는 해커의 ID이고, name은 해커의 이름입니다.
-- Difficulty: difficulty_level은 챌린지의 난이도이며, score는 해당 난이도에 대한 챌린지의 점수입니다.
-- Challenges: challenge_id는 챌린지의 ID이고, hacker_id는 챌린지를 생성한 해커의 ID이며, difficulty_level은 챌린지의 난이도입니다.
-- Submissions: submission_id는 제출의 ID이고, hacker_id는 제출한 해커의 ID이며, challenge_id는 해당 제출이 속한 챌린지의 ID이고, score는 제출 점수입니다.

-- 샘플 출력
-- 90411 Joe

-- 설명
-- 해커 86870은 난이도 2의 챌린지 71055에서 30점을 받아 만점을 획득했습니다.
-- 해커 90411도 난이도 2의 챌린지 71055에서 30점을 받아 만점을 획득했습니다.
-- 해커 90411은 난이도 6의 챌린지 66730에서도 100점을 받아 만점을 획득했습니다.
-- 만점 획득한 챌린지가 두 개 이상인 해커는 90411 뿐이므로, hacker_id와 이름을 공백으로 구분하여 출력합니다.

# 쿼리를 작성하는 목표, 확인할 지표 : 여러 챌린지에서 만점을 받은 해커의 정보 출력 / DIFFICULTY_LEVEL, SCORE, COUNT(CHALLENGE_ID) 
# 쿼리 계산 방법 :
# 1. SUBMISSIONS와 CHALLENGES를 조인하여, 해커가 받은 SCORE(점수)옆에 DIFFICULTY_LEVEL(난이도)를 붙인다. ->
# 2. DIFFICULTY 테이블과의 조인으로, 해커가 받은 SCORE(점수)와 PERFECT_SCORE(만점 점수)를 비교하기 쉽게 붙인다. ->
# 3. 조건문으로 만점을 받은 경우만 걸러낸다. ->
# 4. 해커 별 그룹화와 HAVING 조건으로 만점을 받은 챌린지의 수가 2개 이상인 해커만 추출한다. ->
# 5. HACKERS 테이블과 조인으로 해커의 NAME을 가져온다. -> 
# 6. 정렬
# 데이터의 기간 :
# 사용할 테이블 : SUBMISSIONS, CHALLENGES, DIFFICULTY, HACKERS
# Join KEY : CHALLENGE_ID, DIFFICULTY_LEVEL, HACKER_ID
# 데이터 특징 :

SELECT
    BASE2.HACKER_ID,
    HACK.NAME
FROM (
SELECT
    HACKER_ID,
    COUNT(CHALLENGE_ID) AS PERFECT_CNT 
FROM (
    SELECT
        SUB_SCORE_AND_ID.HACKER_ID,
        SUB_SCORE_AND_ID.CHALLENGE_ID,
        SUB_SCORE_AND_ID.DIFFICULTY_LEVEL,
        SUB_SCORE_AND_ID.SUB_SCORE,
        DIF.SCORE AS PERFECT_SCORE
    FROM (
    SELECT
        SUB.HACKER_ID,
        SUB.CHALLENGE_ID,
        SUB.SCORE AS SUB_SCORE,
        CHA.DIFFICULTY_LEVEL
    FROM SUBMISSIONS AS SUB
    INNER JOIN CHALLENGES AS CHA
    ON SUB.CHALLENGE_ID = CHA.CHALLENGE_ID
    ) AS SUB_SCORE_AND_ID
    INNER JOIN DIFFICULTY AS DIF
    ON SUB_SCORE_AND_ID.DIFFICULTY_LEVEL = DIF.DIFFICULTY_LEVEL
    WHERE
        SUB_SCORE_AND_ID.SUB_SCORE = DIF.SCORE
) AS BASE
GROUP BY
    HACKER_ID
HAVING
    COUNT(CHALLENGE_ID) > 1
) AS BASE2
INNER JOIN HACKERS AS HACK
ON BASE2.HACKER_ID = HACK.HACKER_ID
ORDER BY
    BASE2.PERFECT_CNT DESC,
    HACKER_ID ASC
