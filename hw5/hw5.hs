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

