# 쿼리를 작성하는 목표, 확인할 지표 : dna_sequence의 글자로 인한 분류 / dna_sequence
# 쿼리 계산 방법 : 1. ATG로 시작하는지, TAA로 끝나는지, ATAT를 포함하는지, GGG를 포함하는지 CASE WHEN 으로 분류 -> 2. 정렬
# 데이터의 기간 : x
# 사용할 테이블 : samples
# JOIN KEY : x
# 데이터 특징 : x
SELECT
    sample_id,
    dna_sequence,
    species,
    # 1
    IF(dna_sequence LIKE('ATG%'), 1, 0) AS has_start,
    IF(dna_sequence LIKE('%TAA') OR dna_sequence LIKE('%TAG') OR dna_sequence LIKE('%TGA'), 1, 0) AS has_stop,
    IF(dna_sequence LIKE('%ATAT%'), 1, 0) AS has_atat,
    IF(dna_sequence REGEXP 'G{3,}', 1, 0) AS has_ggg
FROM samples
# 2
ORDER BY
    sample_id

# REGEXP : 정규 표현식(Regular Expression)을 사용하여 패턴 매칭을 수행하는 연산자
# G{3,} : G(문자), {3,}(최소 3번 이상 반복 = 3개 이상 연속)
# 다만 REGEXP는 대소문자를 구분하지 않음. (ggg도 인식)
