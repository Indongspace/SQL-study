-- You did such a great job helping Julia with her last coding contest challenge that she wants you to work on this one, too!
-- The total score of a hacker is the sum of their maximum scores for all of the challenges. Write a query to print the hacker_id, name, and total score of the hackers ordered by the descending score. If more than one hacker achieved the same total score, then sort the result by ascending hacker_id. Exclude all hackers with a total score of  from your result.
-- Input Format
-- The following tables contain contest data:
-- Hackers: The hacker_id is the id of the hacker, and name is the name of the hacker.
-- Submissions: The submission_id is the id of the submission, hacker_id is the id of the hacker who made the submission, challenge_id is the id of the challenge for which the submission belongs to, and score is the score of the submission.

-- Sample Output
-- 4071 Rose 191
-- 74842 Lisa 174
-- 84072 Bonnie 100
-- 4806 Angela 89
-- 26071 Frank 85
-- 80305 Kimberly 67
-- 49438 Patrick 43

-- Explanation
-- Hacker 4071 submitted solutions for challenges 19797 and 49593, so the total score 191. 
-- Hacker 74842 submitted solutions for challenges 19797 and 63132, so the total score 174. 
-- Hacker 84072 submitted solutions for challenges 49593 and 63132, so the total score 100. 
-- The total scores for hackers 4806, 26071, 80305, and 49438 can be similarly calculated.
-- 줄리아의 지난 코딩 대회 문제를 도와준 당신의 도움에 감명을 받은 줄리아는 이번 문제도 당신이 해결해주기를 원합니다!
-- 해커의 총 점수는 각 문제에서 얻은 최고 점수들의 합입니다. 해커의 hacker_id, name, 그리고 총 점수를 출력하는 쿼리를 작성하세요. 결과는 총 점수를 기준으로 내림차순으로 정렬합니다. 만약 두 명 이상의 해커가 동일한 총 점수를 달성했다면, hacker_id를 기준으로 오름차순 정렬합니다. 총 점수가 0인 해커는 결과에서 제외하세요.
-- 입력 형식
-- 다음의 테이블들이 주어집니다:
-- Hackers: hacker_id는 해커의 ID이고, name은 해커의 이름입니다.
-- Submissions: submission_id는 제출 ID이고, hacker_id는 제출한 해커의 ID입니다. challenge_id는 제출된 문제의 ID이며, score는 제출된 점수입니다.

-- 예시 출력
-- 4071 Rose 191
-- 74842 Lisa 174
-- 84072 Bonnie 100
-- 4806 Angela 89
-- 26071 Frank 85
-- 80305 Kimberly 67
-- 49438 Patrick 43

-- 설명
-- 해커 4071은 문제 19797과 49593에 대해 제출하여 총 점수 191을 기록했습니다.
-- 해커 74842는 문제 19797과 63132에 대해 제출하여 총 점수 174를 기록했습니다.
-- 해커 84072는 문제 49593과 63132에 대해 제출하여 총 점수 100을 기록했습니다.
-- 해커 4806, 26071, 80305, 49438의 총 점수는 비슷한 방식으로 계산할 수 있습니다.

# 쿼리를 작성하는 목표, 확인할 지표 : 해커의 ID,NAME,총 점수 출력 / SCORE
# 쿼리 계산 방법 : 1. 해커별, 문제별로 가장 높은 값MAX 추출 -> 2. 해커별 그룹화 총 점수 추출SUM
# -> 3. 총 점수가 0인 사람 제외 조건 -> 4. HACKERS 테이블과 INNER JOIN -> 5. 정렬
# 데이터의 기간 :
# 사용할 테이블 : HACKERS, SUBMISSIONS
# Join KEY : HACKER_ID
# 데이터 특징 :
SELECT
    BASE.HACKER_ID,
    HACK.NAME,
    BASE.RESULT AS SCORE
FROM (
	# 2. 해커별 그룹화 총 점수 추출SUM
    SELECT
        HACKER_ID,
        SUM(MAX_SCORE) AS RESULT
    FROM (
        # 1. 해커별, 문제별로 가장 높은 값MAX 추출
        SELECT
            HACKER_ID,
            CHALLENGE_ID,
            MAX(SCORE) AS MAX_SCORE
        FROM SUBMISSIONS
        GROUP BY
            HACKER_ID,
            CHALLENGE_ID
    ) AS GROUPY_MAX_SCORE
    GROUP BY
        HACKER_ID
    # 3. 총 점수가 0인 사람 제외 조건
    HAVING
        SUM(MAX_SCORE) != 0
) AS BASE
# 4. HACKERS 테이블과 INNER JOIN
INNER JOIN HACKERS AS HACK
ON BASE.HACKER_ID = HACK.HACKER_ID
# 5. 정렬
ORDER BY
    SCORE DESC,
    HACKER_ID ASC
    
