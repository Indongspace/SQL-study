-- Generate the following two result sets:
-- Query an alphabetically ordered list of all names in OCCUPATIONS, immediately followed by the first letter of each profession as a parenthetical (i.e.: enclosed in parentheses). For example: AnActorName(A), ADoctorName(D), AProfessorName(P), and ASingerName(S).
-- Query the number of ocurrences of each occupation in OCCUPATIONS. Sort the occurrences in ascending order, and output them in the following format:
-- There are a total of [occupation_count] [occupation]s.
-- where [occupation_count] is the number of occurrences of an occupation in OCCUPATIONS and [occupation] is the lowercase occupation name. If more than one Occupation has the same [occupation_count], they should be ordered alphabetically.

-- Note: There will be at least two entries in the table for each type of occupation.

-- Input Format
-- The OCCUPATIONS table is described as follows:
-- Occupation will only contain one of the following values: Doctor, Professor, Singer or Actor.

-- Sample Input
-- An OCCUPATIONS table that contains the following records:

-- Sample Output
-- Ashely(P)
-- Christeen(P)
-- Jane(A)
-- Jenny(D)
-- Julia(A)
-- Ketty(P)
-- Maria(A)
-- Meera(S)
-- Priya(S)
-- Samantha(D)
-- There are a total of 2 doctors.
-- There are a total of 2 singers.
-- There are a total of 3 actors.
-- There are a total of 3 professors.

-- Explanation
-- The results of the first query are formatted to the problem description's specifications.
-- The results of the second query are ascendingly ordered first by number of names corresponding to each profession (2<=2<=3<=3), and then alphabetically by profession (doctor<=singer, and actor<=professor).

-- 다음 두 개의 결과 집합을 생성하세요:
-- OCCUPATIONS 테이블의 모든 이름을 알파벳순으로 정렬하고, 각 이름 뒤에 직업의 첫 글자를 괄호로 묶어서 나타내세요. 예를 들어: AnActorName(A), ADoctorName(D), AProfessorName(P), ASingerName(S)와 같이 출력하세요.
-- 각 직업의 빈도를 출력하세요. 빈도는 오름차순으로 정렬하며, 아래 형식에 따라 출력하세요:
-- There are a total of [occupation_count] [occupation]s.
-- 여기서 [occupation_count]는 해당 직업의 빈도수를 나타내고, [occupation]은 소문자로 된 직업명입니다. 만약 여러 직업이 동일한 [occupation_count] 값을 갖는 경우, 직업명을 알파벳순으로 정렬합니다.

-- 입력 형식
-- OCCUPATIONS 테이블의 설명은 다음과 같습니다:
-- Occupation은 다음 값 중 하나만 가질 수 있습니다: Doctor, Professor, Singer, Actor.

-- 예시 입력
-- 다음과 같은 레코드를 포함하는 OCCUPATIONS 테이블:

-- 예시 출력
-- Ashely(P)
-- Christeen(P)
-- Jane(A)
-- Jenny(D)
-- Julia(A)
-- Ketty(P)
-- Maria(A)
-- Meera(S)
-- Priya(S)
-- Samantha(D)
-- There are a total of 2 doctors.
-- There are a total of 2 singers.
-- There are a total of 3 actors.
-- There are a total of 3 professors.

-- 설명
-- 첫 번째 쿼리의 결과는 문제 설명에 맞게 형식이 지정되어 있습니다.
-- 두 번째 쿼리의 결과는 직업별 빈도가 오름차순으로 정렬되어 있으며, 빈도가 같을 경우 직업명을 알파벳순으로 정렬합니다 (2<=2<=3<=3), 그리고 doctor<=singer 및 actor<=professor 순입니다.

# 쿼리를 작성하는 목표, 확인할 지표 : OCCUPATIONS 테이블의 모든 이름을 알파벳순으로 정렬하고 각 이름 뒤에 직업의 첫 글자를 괄호로 묶어서, 각 직업의 빈도를 출력 / occupation, COUNT(occupation)
# 쿼리 계산 방법 : 
# 1. CONCAT 함수를 이용해 이름 옆에 occupation의 첫 글자를 붙이고 이름 알파벳 순 정렬 -> 결과1
# 2. 직업 순 그룹화, COUNT 직업 명 수 ->
# 3. CONCAT 함수를 이용해 원하는 텍스트를 붙여서 출력 ->
# 4. 직업별 명 수, 직업알파벳 순 정렬
# 데이터의 기간 :
# 사용할 테이블 : occupations
# Join KEY :
# 데이터 특징 :
SELECT
	# 1. CONCAT 함수를 이용해 이름 옆에 occupation의 첫 글자를 붙이고 이름 알파벳 순 정렬
    CONCAT(name, '(', LEFT(occupation, 1), ')') AS name_with_occupation
FROM occupations
ORDER BY
    name;

SELECT
	# 3. CONCAT 함수를 이용해 원하는 텍스트를 붙여서 출력
    CONCAT('There are a total of ', COUNT(occupation), ' ', LOWER(occupation), 's.') AS occupation_cnt
FROM occupations
# 2. 직업 순 그룹화, COUNT 직업 명 수
GROUP BY
    occupation
# 4. 직업별 명 수, 직업알파벳 순 정렬
ORDER BY
    COUNT(occupation),
    occupation
    
