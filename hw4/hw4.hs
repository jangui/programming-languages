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
              --if not open insert on right
              (Node (v2, n2) l2 r2) -> (Node (v, n) l (bstInsert (Node (v2, n2) l2 r2) val))
          else 
            --val is less, go to left
            case l of
              --if space, pop it in
              Leaf -> (Node (v, n) (Node (val, 1) Leaf Leaf) r)
              -- else insert in left
              (Node (v2, n2) l2 r2) -> (Node (v,n) (bstInsert (Node (v2, n2) l2 r2) val) r)

--Question 5
bstLookup :: Ord a => a -> Tree (a, Int) -> Int
bstLookup a Leaf = 0
bstLookup a (Node (v, n) l r) = 
  if v == a
    then n
    else 
      if v > a
        then bstLookup a l
        else bstLookup a r

--Question 6
bstRemove :: Ord a => Tree (a, Int) -> a -> Maybe (Tree (a, Int))
bstRemove Leaf a = Nothing
bstRemove (Node (v, n) l r) a =
--check if a same as parent node
  if a == v
    --if so remove, or decr count
    then 
      case n of
      1 -> (removeHelp (Node (v, n) l r) a)
      i -> Just (Node (v, (n-1)) l r)
    else 
        --check if greater than
        if a > v
          then --go to right
            --if exists remove from right
            case r of
              Leaf -> Nothing
              (Node (v2, n2) l2 r2) -> 
                case (bstRemove (Node (v2, n2) l2 r2) a) of
                  Nothing -> Nothing
                  Just (Node (v3, n3) l3 r3) -> Just (Node (v, n) l (Node (v3, n3) l3 r3))
          else 
            --a is less, its in the left
            case l of
              --if left is leaf, a not in tree
              Leaf -> Nothing
              -- else check if a is == to value in child node
              (Node (v2, n2) l2 r2) ->
                case (bstRemove (Node (v2, n2) l2 r2) a) of
                  Nothing -> Nothing
                  Just (Node (v3, n3) l3 r3) -> Just (Node (v, n) (Node (v3, n3) l3 r3) r)

--only called when when are removing root of tree passed
removeHelp :: Ord a => Tree (a, Int) -> a -> Maybe (Tree (a, Int))
removeHelp (Node (v, n) Leaf Leaf) a = Just Leaf

--Question 7
instance Show a => Show (Tree a) where
  show mytree = printTree mytree 0

--using 2 spaces instead of tabs
printTree :: Show a => Tree a -> Int -> String
printTree Leaf 0 = "Leaf"
printTree Leaf n = ""
printTree (Node v l r) n = (multStr n "  ") ++ "Node" ++ show v ++ "\n" ++ (printTree l (n+1)) ++ (printTree r (n+1))

multStr :: Int -> String -> String
multStr 0 str = ""
multStr n str = str ++ multStr (n-1) str
