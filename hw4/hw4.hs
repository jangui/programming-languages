{-
 - Jaime Danguillecourt
 - jd3846
 - HW 4
 -}

import qualified Data.Map as Map
import Data.Map (Map)

--Question 1
frequency :: Ord a => [a] -> Map a Int
frequency [] = Map.empty
frequency (h:t) =
  case Map.lookup h map of
    Just n -> Map.insert h (n + 1) (map)
    Nothing -> Map.insert h 1 (map)
  where map = (frequency t)

--Question 2
data Tree a = Node a (Tree a) (Tree a)
            | Leaf
            deriving Show

instance Eq a => Eq (Tree a) where
  Leaf == Leaf = True
  (Node v l r) == Leaf = False
  Leaf == (Node v l r) = False
  (Node v1 l1 r1) == (Node v2 l2 r2) =
    v1 == v2 && l1 == l2 && r1 == r2 

someTree :: Tree String
someTree = Node "t1"(Node "t2a" (Node "t3a" Leaf Leaf) (Node "t3b" Leaf Leaf)) (Node "t2b" (Node "t3c" Leaf Leaf) (Node "t3d" Leaf Leaf))

--Question 3
instance Functor Tree where
  fmap f (Node v l r) = mapTree f (Node v l r)
  fmap f Leaf = Leaf

mapTree :: (a->b) -> Tree a -> Tree b
mapTree func (Node val left right) = Node (func val) (mapTree func left) (mapTree func right)
mapTree _ Leaf = Leaf

--Question 4

bstInsert :: Ord a => Tree (a, Int) -> a -> Tree(a, Int)
bstInsert Leaf val = (Node (val, 1) Leaf Leaf)
bstInsert (Node (v, n) l r) val = 
--check if val same as parent node
  if val == v
    --if so inc count
    then (Node (v, n+1) l r)
    else 
        --check if greater than
        if val > v
          then 
          --we have to insert into right
            case r of
              --if right spot open, insert
              Leaf -> (Node (v, n) l (Node (val, 1) Leaf Leaf))
              --if not open, check if we should increment the count on right, or insert
              (Node (v2, n2) l2 r2) ->
                if val == v 
                  then
                    (Node (v, n) l (Node (v2, n2+1) l2 r2))
                  else (Node (v, n) l (bstInsert (Node (v2, n2) l2 r2) val))
          else 
            --val is less, insert to left
            case l of
              --if space, pop it in
              Leaf -> (Node (v, n) (Node (val, 1) Leaf Leaf) r)
              -- else check if left node needs an increment, or an insert
              (Node (v2, n2) l2 r2) ->
                if val == v
                  then (Node (v, n) (Node (v2, n2+1) l2 r2) r)
                  else (Node (v,n) (bstInsert (Node (v2, n2) l2 r2) val) r)

--Question 5
