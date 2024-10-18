-- You are given three tables: Students, Friends and Packages. Students contains two columns: ID and Name. Friends contains two columns: ID and Friend_ID (ID of the ONLY best friend). Packages contains two columns: ID and Salary (offered salary in $ thousands per month).
-- Write a query to output the names of those students whose best friends got offered a higher salary than them. Names must be ordered by the salary amount offered to the best friends. It is guaranteed that no two students got same salary offer.
-- Now,
-- Samantha's best friend got offered a higher salary than her at 11.55
-- Julia's best friend got offered a higher salary than her at 12.12
-- Scarlet's best friend got offered a higher salary than her at 15.2
-- Ashley's best friend did NOT get offered a higher salary than her
-- The name output, when ordered by the salary offered to their friends, will be:
-- Samantha
-- Julia
-- Scarlet

-- 다음과 같은 세 개의 테이블이 주어졌습니다: Students, Friends, Packages.
-- Students 테이블에는 두 개의 열이 있습니다: ID와 Name.
-- Friends 테이블에는 두 개의 열이 있습니다: ID와 Friend_ID (유일한 가장 친한 친구의 ID).
-- Packages 테이블에는 두 개의 열이 있습니다: ID와 Salary (제안된 월 급여, 천 달러 단위).
-- 이제 해야 할 일은 다음과 같습니다: 가장 친한 친구가 자신보다 더 높은 급여를 제안받은 학생들의 이름을 출력하는 쿼리를 작성하세요. 이름은 가장 친한 친구가 제안받은 급여 금액 순으로 정렬되어야 합니다. 두 학생이 동일한 급여를 제안받은 경우는 없습니다.
-- Samantha의 가장 친한 친구가 그녀보다 높은 급여인 11.55를 제안받음
-- Julia의 가장 친한 친구가 그녀보다 높은 급여인 12.12를 제안받음
-- Scarlet의 가장 친한 친구가 그녀보다 높은 급여인 15.2를 제안받음
-- Ashley의 가장 친한 친구는 그녀보다 높은 급여를 제안받지 않음
-- 가장 친한 친구에게 제안된 급여 순으로 이름을 정렬하면 출력은 다음과 같습니다:
-- Samantha
-- Julia
-- Scarlet

WITH STUDENTS_SALARY AS (
    SELECT
        STD.ID,
        STD.NAME,
        PACK.SALARY
    FROM STUDENTS AS STD
    INNER JOIN PACKAGES AS PACK
    ON STD.ID = PACK.ID
), FRIENDS_SALARY AS (
    SELECT
        FRI.ID,
        FRI.FRIEND_ID,
        PACK.SALARY
    FROM FRIENDS AS FRI
    INNER JOIN PACKAGES AS PACK
    ON FRI.FRIEND_ID = PACK.ID
)
SELECT  
    SS.NAME
FROM STUDENTS_SALARY AS SS
INNER JOIN FRIENDS_SALARY AS FS
ON SS.ID = FS.ID
WHERE
    SS.SALARY < FS.SALARY
ORDER BY
    FS.SALARY ASC
    