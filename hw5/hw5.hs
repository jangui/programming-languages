{-
 - Jaime Danguillecourt
 - jd3846
 - HW5
 -}

{- Question 1
 
 The given function is not tail recursive. Fix:
 
  def mystery(lst, lst2=[]):
    if len(lst) < 2:
      return lst2 + lst
      lst2 = lst2 +[lst[1]] + [lst[0]]
    return mystery(lst[2:], lst2)
-}

--Question 2
data Stream a = Chunk a (Stream a)

streamToList :: Stream a -> [a]
streamToList (Chunk v next) = v : streamToList next

streamRepeat :: a -> Stream a
streamRepeat a = Chunk a (streamRepeat a)

--Question 3
instance Functor Stream where
  fmap f (Chunk a s) = Chunk (f a) (fmap f s)

--Question 4
streamFromSeed :: (a -> a) -> a -> Stream a
streamFromSeed f a =
  let v = f a
  in Chunk v (streamFromSeed f v)

--Question 5
data Tree a = Node a (Tree a) (Tree a)
            | Leaf

bigTree :: Tree Integer
bigTree = bigTreeHelp (Node 0 Leaf Leaf)

bigTreeHelp :: Tree Integer -> Tree Integer
bigTreeHelp (Node v Leaf Leaf) = 
  let t = bigTreeHelp (Node (v+1) Leaf Leaf)
  in Node v t t

--Question 6
collatz :: Integer -> Stream Integer
collatz i =
  if ((even i) == True)
    then Chunk i (collatz (div i 2))
    else Chunk i (collatz (3*i+1))

--Question 7
collatzLength :: Integer -> Integer
collatzLength n = 
  case collatz n of
    (Chunk 1 s) -> 0
    (Chunk a (Chunk b s)) -> 1 + collatzLength b

--Question 8
longestCollatz :: Integer -> Integer
longestCollatz i = v
  where (maxlen, v) = largest (zip (map collatzLength [1..i]) [1..i])

largest :: [(Integer, Integer)] -> (Integer, Integer)
largest [a] = a
largest ((l,v):t) =
  if l > maxlen
    then (l,v)
    else (maxlen, v2)
    where (maxlen, v2) = largest t
