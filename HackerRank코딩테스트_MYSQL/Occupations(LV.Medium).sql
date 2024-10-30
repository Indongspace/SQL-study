-- Pivot the Occupation column in OCCUPATIONS so that each Name is sorted alphabetically and displayed underneath its corresponding Occupation. The output column headers should be Doctor, Professor, Singer, and Actor, respectively.

-- Note: Print NULL when there are no more names corresponding to an occupation.

-- Input Format

-- The OCCUPATIONS table is described as follows:
-- Occupation will only contain one of the following values: Doctor, Professor, Singer or Actor.

-- Sample Output
-- Jenny    Ashley     Meera  Jane
-- Samantha Christeen  Priya  Julia
-- NULL     Ketty      NULL   Maria

-- Explanation
-- The first column is an alphabetically ordered list of Doctor names.
-- The second column is an alphabetically ordered list of Professor names.
-- The third column is an alphabetically ordered list of Singer names.
-- The fourth column is an alphabetically ordered list of Actor names.
-- The empty cell data for columns with less than the maximum number of names per occupation (in this case, the Professor and Actor columns) are filled with NULL values.

-- OCCUPATIONS 테이블에서 Occupation 열을 피벗하여 각 이름을 해당 직업 아래에 표시하되, 이름은 알파벳순으로 정렬되어야 합니다. 출력 열 헤더는 각각 Doctor, Professor, Singer, 그리고 Actor가 되어야 합니다.

-- 참고 사항: 각 직업에 해당하는 이름이 더 이상 없는 경우 NULL을 출력합니다.

-- 입력 형식
-- OCCUPATIONS 테이블은 다음과 같이 설명됩니다.
-- Occupation 열에는 오직 다음 값들만 포함됩니다: Doctor, Professor, Singer, 또는 Actor.

-- 예제 출력
-- Jenny    Ashley     Meera  Jane
-- Samantha Christeen  Priya  Julia
-- NULL     Ketty      NULL   Maria

-- 설명
-- 첫 번째 열은 알파벳순으로 정렬된 Doctor 이름 목록입니다.
-- 두 번째 열은 알파벳순으로 정렬된 Professor 이름 목록입니다.
-- 세 번째 열은 알파벳순으로 정렬된 Singer 이름 목록입니다.
-- 네 번째 열은 알파벳순으로 정렬된 Actor 이름 목록입니다.
-- 각 직업에 속하는 이름의 최대 개수보다 적은 경우 NULL로 빈 셀을 채웁니다.

# 쿼리를 작성하는 목표, 확인할 지표 : 데이터를 피벗해서 각 이름을 해당 직업 아래에 표시 / occupation, name
# 쿼리 계산 방법 :
# 1. 윈도우 함수를 이용해 occupation 별로, 이름순으로 정렬한 행의 순위숫자 붙이기 ->
# 2. case문으로 직업에 일치하는 이름을 행으로, 직업이름들을 열로 피벗 ->
# 3. 한 행에 직업이 일치하는 이름과, 나머지 세 직업은 이름이 NULL로 표시가 되어있을텐데 group by로 MAX값(NULL이 아닌) 추출 ->
# 4. 정렬
# 데이터의 기간 :
# 사용할 테이블 : occupations
# Join KEY :
# 데이터 특징 :
WITH occupation_rows AS (
    SELECT
        occupation,
        name,
        # 1. 윈도우 함수를 이용해 occupation 별로 이름순으로 정렬한 행의 순위숫자 붙이기
        ROW_NUMBER() OVER(PARTITION BY occupation ORDER BY name) AS row_num
    FROM occupations 
)
SELECT
	# 2. case문으로 직업에 일치하는 이름 컬럼을 행으로, 직업이름을 열로 피벗
    MAX(CASE WHEN occupation = 'Doctor' THEN name END) AS Doctor,
    MAX(CASE WHEN occupation = 'Professor' THEN name END) AS Professor,
    MAX(CASE WHEN occupation = 'Singer' THEN name END) AS Singer,
    MAX(CASE WHEN occupation = 'Actor' THEN name END) AS Actor
FROM occupation_rows
# 3. 한 행에 직업이 일치하는 이름과, 나머지 세 직업열에는 이름이 NULL로 표시가 되어있을텐데 group by로 MAX값(NULL이 아닌) 추출  
GROUP BY
    row_num
# 4. 정렬
ORDER BY
    row_num
    