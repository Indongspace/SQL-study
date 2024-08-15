-- 동물 보호소에 들어온 모든 동물의 아이디와 이름, 보호 시작일을 이름 순으로 조회하는 SQL문을 작성해주세요. 
-- 단, 이름이 같은 동물 중에서는 보호를 나중에 시작한 동물을 먼저 보여줘야 합니다.
-- 이름을 사전 순으로 정렬하면 다음과 같으며, 'Jewel', 'Raven', 'Sugar'
-- 'Raven'이라는 이름을 가진 개와 고양이가 있으므로, 이 중에서는 보호를 나중에 시작한 개를 먼저 조회합니다.
# 쿼리를 작성하는 목표, 확인할 지표 : 이름 순으로 출력 보호를 나중에 시작한 시간 먼저
# 쿼리 계산 방법 : name asc / datetime desc
# 데이터의 기간 :
# 사용할 테이블 : aac_intakes
# Join KEY :
# 데이터 특징 

SELECT
	animal_id,
    name,
    datetime
FROM for_coding_test.aac_intakes
ORDER BY
	name ASC,
    datetime DESC

	