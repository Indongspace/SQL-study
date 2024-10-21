-- You are given a table, Projects, containing three columns: Task_ID, Start_Date and End_Date. It is guaranteed that the difference between the End_Date and the Start_Date is equal to 1 day for each row in the table.
-- If the End_Date of the tasks are consecutive, then they are part of the same project. Samantha is interested in finding the total number of different projects completed.
-- Write a query to output the start and end dates of projects listed by the number of days it took to complete the project in ascending order. If there is more than one project that have the same number of completion days, then order by the start date of the project.

-- Sample Output
-- 2015-10-28 2015-10-29
-- 2015-10-30 2015-10-31
-- 2015-10-13 2015-10-15
-- 2015-10-01 2015-10-04

-- Explanation
-- The example describes following four projects:
-- Project 1: Tasks 1, 2 and 3 are completed on consecutive days, so these are part of the project. Thus start date of project is 2015-10-01 and end date is 2015-10-04, so it took 3 days to complete the project.
-- Project 2: Tasks 4 and 5 are completed on consecutive days, so these are part of the project. Thus, the start date of project is 2015-10-13 and end date is 2015-10-15, so it took 2 days to complete the project.
-- Project 3: Only task 6 is part of the project. Thus, the start date of project is 2015-10-28 and end date is 2015-10-29, so it took 1 day to complete the project.
-- Project 4: Only task 7 is part of the project. Thus, the start date of project is 2015-10-30 and end date is 2015-10-31, so it took 1 day to complete the project.
-- 다음과 같은 테이블, Projects,이 주어집니다. 이 테이블에는 Task_ID, Start_Date, End_Date라는 세 개의 열이 있습니다. 각 행에서 End_Date와 Start_Date의 차이는 항상 1일로 보장됩니다.
-- 만약 작업들의 End_Date가 연속적이라면, 이는 같은 프로젝트의 일부입니다. Samantha는 완료된 서로 다른 프로젝트의 총 수를 찾는 데 관심이 있습니다.
-- 프로젝트의 시작일과 종료일을 출력하는 쿼리를 작성하세요. 프로젝트를 완료하는 데 걸린 일수를 기준으로 오름차순으로 정렬하세요. 만약 여러 프로젝트가 동일한 완료 일수를 가진다면, 프로젝트의 시작일을 기준으로 정렬하세요.
-- 설명
-- 예제는 다음과 같은 네 가지 프로젝트를 설명합니다:
-- 프로젝트 1: 작업 1, 2, 3은 연속된 날에 완료되었으므로 같은 프로젝트의 일부입니다. 따라서 프로젝트의 시작일은 2015-10-01이고 종료일은 2015-10-04이며, 프로젝트를 완료하는 데 3일이 걸렸습니다.
-- 프로젝트 2: 작업 4와 5는 연속된 날에 완료되었으므로 같은 프로젝트의 일부입니다. 따라서 프로젝트의 시작일은 2015-10-13이고 종료일은 2015-10-15이며, 프로젝트를 완료하는 데 2일이 걸렸습니다.
-- 프로젝트 3: 작업 6은 혼자만 프로젝트의 일부입니다. 따라서 프로젝트의 시작일은 2015-10-28이고 종료일은 2015-10-29이며, 프로젝트를 완료하는 데 1일이 걸렸습니다.
-- 프로젝트 4: 작업 7도 혼자만 프로젝트의 일부입니다. 따라서 프로젝트의 시작일은 2015-10-30이고 종료일은 2015-10-31이며, 프로젝트를 완료하는 데 1일이 걸렸습니다.

# 쿼리를 작성하는 목표, 확인할 지표 : 프로젝트 시작일과 종료일 별로 프로젝트를 구분하고 걸린 일수를 기준으로 오름차순
# / START_DATE, END_DATE
# 쿼리 계산 방법 : 1. END_DATE에 없는 START_DATE 추출 => 그럼 START_DATE에는 프로젝트 시작일만 추출될 것. ->
# 2. START_DATE에 없는 END_DATE 추출 => 그럼 END_DATE에는 프로젝트 끝나는 날만 추출될 것. -> 
# 3. 3. 1&2의 카티션 곱으로 모든 경우의 수를 추출한다. -> 4. 모든 경우의 수 중에서 시작일이 종료일보다 작은 경우만 추출.
# -> 5-1. 시작일 별로 그룹화 -> 5-2. 값은, 그룹의 가장 작은 종료일 조회 -> 6. 프로젝트 종료일과 시작일 차이가 가장 적은 프로젝트 순 ~ 시작일이 가장 작은 순
# 데이터의 기간 :
# 사용할 테이블 : PROJECTS
# Join KEY :
# 데이터 특징 :
SELECT
    START_DATE,
    # 5-2. 값은, 그룹의 가장 작은 종료일 조회
    MIN(END_DATE)
FROM (
	# 1. END_DATE에 없는 START_DATE 추출 => 그럼 START_DATE에는 프로젝트 시작일만 추출될 것.
    SELECT
        START_DATE
    FROM PROJECTS
    WHERE START_DATE NOT IN (SELECT END_DATE FROM PROJECTS)
) A, # 3. 1&2의 카티션 곱으로 모든 경우의 수를 추출한다.
(
	# 2. START_DATE에 없는 END_DATE 추출 => 그럼 END_DATE에는 프로젝트 끝나는 날만 추출될 것.
    SELECT
        END_DATE
    FROM PROJECTS
    WHERE END_DATE NOT IN (SELECT START_DATE FROM PROJECTS)
) B
# 4. 모든 경우의 수 중에서 시작일이 종료일보다 작은 경우만 추출.
WHERE
    START_DATE < END_DATE
# 5-1. 시작일 별로 그룹화
GROUP BY
    START_DATE
# 6. 프로젝트 종료일과 시작일 차이가 가장 적은 프로젝트 순 ~ 시작일이 가장 작은 순
ORDER BY
    MIN(END_DATE) - START_DATE ASC,
    START_DATE ASC


