-- HW 1
-- Jaime Danguillecourt
-- jd3846

{- Question 1
 - a) z y
 - b) y
 - c) (\x.\y.a x y c)
 - d) (\y.y y)
 - e) infinite loop
 - f) \y.z
 
-- Question 2
 - \m.\n.m (plus n)

-- Question 3
 - \n.n not true
-}

-- Question 4

harmonic :: Int -> Double
harmonic 0 = 0.0
harmonic 1 = 1.0
harmonic n = (1.0/ fromIntegral n) + harmonic ( n - 1)

-- Question 5
countQs :: String -> Int
countQs [] = 0
countQs (h:t) =
  if h == 'q'
    then 1 + qs_in_tail
    else qs_in_tail
  where qs_in_tail = countQs t

-- Question 6
mytake :: Int -> [String] -> [String]
mytake 0 lst = []
mytake n (h:t) = h : mytake (n-1) t
mytake n [] = []

-- Question 7
mylast :: [Int] -> Int
mylast [a] = a
mylast [] = 0
mylast (h:t) = mylast t

-- Question 8
range :: Int -> Int -> [Int]
range x y = 
  if (x > y)
    then []
    else x : range (x+1) y

-- Question 9

firstCharRun :: String -> Int
firstCharRun [] = 0
firstCharRun (h:t) = 
  if t == []
    then 1
    else
      if h == head t
        then 1 + firstCharRun t
        else 1

longestRun :: String -> Int
longestRun [] = 0
longestRun (h:t) = 
  if (runFromHead > runFromTail)
    then runFromHead
    else runFromTail
  where runFromHead = firstCharRun (h:t)
        runFromTail = longestRun t
