{-
 - Jaime Danguillecourt
 - jd3846
 - HW3
-}

data Tree a = Node a (Tree a) (Tree a)
            | Leaf
            deriving Show

someTree :: Tree String
someTree = Node "t1"(Node "t2a" (Node "t3a" Leaf Leaf) (Node "t3b" Leaf Leaf)) (Node "t2b" (Node "t3c" Leaf Leaf) (Node "t3d" Leaf Leaf))

--Question 1
mapTree :: (a->b) -> Tree a -> Tree b
mapTree func (Node val left right) = Node (func val) (mapTree func left) (mapTree func right)
mapTree _ Leaf = Leaf

--Question 2
flipTree :: Tree a -> Tree a
flipTree (Node v l r) = Node v (flipTree r) (flipTree l)
flipTree Leaf = Leaf

--Question 3
inorderTraversal :: Tree a -> [a]
inorderTraversal (Node v l r) = (inorderTraversal l) ++ [v] ++ (inorderTraversal r)
inorderTraversal Leaf = []

--Question 4
getLevel :: Int -> Tree a -> [a]
getLevel i (Node v l r) =
  if i == 0
    then [v]
    else getLevel (i-1) l ++ getLevel (i-1) r
getLevel i Leaf = []

--Question 5
mylast :: [a] -> Maybe a
mylast [a] = Just a
mylast (h:t) = mylast t
mylast [] = Nothing

--Question 8

data Graph = GraphNode Int [Graph]

graph1 = GraphNode 1 [GraphNode 2 [GraphNode 5 []], GraphNode 3 [], GraphNode 4 [GraphNode 6 [GraphNode 7 [],        GraphNode 8 []]]]

graph2 = GraphNode 1 [GraphNode 2 [GraphNode 5 []], GraphNode 3 [], GraphNode 4 [GraphNode 6 [GraphNode 7 [graph2],  GraphNode 8 []]]]

graph3 =let mycycle =GraphNode 9 [GraphNode 10 [],GraphNode 11 [], GraphNode 12 [mycycle]]in GraphNode 1 [GraphNode  2 [], GraphNode 3 [],GraphNode 4 [GraphNode 5 [], mycycle]]

hasCycles :: Graph -> Bool
hasCycles (GraphNode val []) = False
hasCycles (GraphNode val nodes) = helper [] (GraphNode val nodes)

helper :: [Int] -> Graph -> Bool
helper seen (GraphNode val []) = False
helper seen (GraphNode val nodes) =
  if (val `elem` seen) == True
    then True
    else
      if True `elem` loops
        then True
      else False
      where
        loops = (map (helper (val : seen)) nodes)
