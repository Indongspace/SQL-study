# 쿼리를 작성하는 목표, 확인할 지표 : 연속으로 세 번 이상 나온 수 추출 / num
# 쿼리 계산 방법 : 1. lead 1과 lead 2로 다음,다다음행 추출 -> 2. 자기자신 & 다음행 & 다다음행이 같은 수 추출
# 데이터의 기간 : x
# 사용할 테이블 : logs
# JOIN KEY : x
# 데이터 특징 : x
SELECT
    DISTINCT num AS consecutivenums
FROM (
    SELECT
        num,
        # 1
        LEAD(num, 1) OVER(ORDER BY id) AS num2,
        LEAD(num, 2) OVER(ORDER BY id) AS num3
    FROM logs
) AS a
# 2
WHERE
    num = num2 AND
    num2 = num3
