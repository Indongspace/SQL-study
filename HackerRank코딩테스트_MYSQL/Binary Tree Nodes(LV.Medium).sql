-- You are given a table, BST, containing two columns: N and P, where N represents the value of a node in Binary Tree, and P is the parent of N.
-- Write a query to find the node type of Binary Tree ordered by the value of the node. Output one of the following for each node:
-- Root: If node is root node.
-- Leaf: If node is leaf node.
-- Inner: If node is neither root nor leaf node.

-- Sample Output
-- 1 Leaf
-- 2 Inner
-- 3 Leaf
-- 5 Root
-- 6 Leaf
-- 8 Inner
-- 9 Leaf

-- Explanation
-- The Binary Tree below illustrates the sample:

-- 주어진 BST 테이블에는 이진 트리의 노드를 나타내는 N과 해당 노드의 부모 노드를 나타내는 P 열이 있습니다.
-- 각 노드의 유형을 다음 중 하나로 출력하는 SQL 쿼리를 작성하세요. 노드의 값을 기준으로 오름차순 정렬하여 결과를 출력해야 합니다.
-- Root: 루트 노드인 경우
-- Leaf: 리프 노드인 경우
-- Inner: 루트도 아니고 리프도 아닌 노드인 경우

-- 예시 출력:
-- 1 Leaf
-- 2 Inner
-- 3 Leaf
-- 5 Root
-- 6 Leaf
-- 8 Inner
-- 9 Leaf

# 쿼리를 작성하는 목표, 확인할 지표 : 노드의 유형을 출력 / n, p 
# 쿼리 계산 방법 : 
# 1. p가 null인 경우는 Root노드 ->
# 2. p가 null이 아닌 경우(=Root노드 하의 노드) 중 n이 p에 없는(=노드(n)가 부모노드가 아닌 노드) 노드(n)는 Leaf노드 ->
# 3. 두 case 모두 아닌 경우는 중간노드임 ->
# 4. 정렬
# 데이터의 기간 :
# 사용할 테이블 : bst
# Join KEY :
# 데이터 특징 :
SELECT
    n,
    CASE
    	# 1. p가 null인 경우는 Root노드
        WHEN p IS NULL THEN 'Root'
        # 2. p가 null이 아닌 경우(=Root노드 하의 노드) 중 n이 p에 없는(=노드(n)가 부모노드가 아닌 노드) 노드(n)는 Leaf노드
        WHEN n NOT IN (SELECT DISTINCT p FROM bst WHERE p IS NOT NULL) THEN 'Leaf'
        # 3. 두 case 모두 아닌 경우는 중간노드임
        ELSE 'Inner'
    END AS node
FROM bst
# 4. 정렬
ORDER BY
    n ASC
