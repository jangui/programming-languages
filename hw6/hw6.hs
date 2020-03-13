{-
 - Jaime Danguillecourt
 - HW 6
 -}

import Control.Monad.State (State, put, get, modify, runState, evalState, execState)

--Question 1
firstWords :: FilePath -> IO ()
firstWords path =
  do contents <- readFile path
     mapM_ putStrLn (getFirstWords contents)

getFirstWords :: String -> [String]
getFirstWords s = map head (map (\x -> if x == [] then [""] else x) (map words (lines s)))


--Question 2
firstWords2 :: FilePath -> IO ()
firstWords2 path = readFile path >>=
                  (\contents -> mapM_ putStrLn (getFirstWords contents))

--Question 3
mymapM :: Monad m => (a -> m b) -> [a] -> m [b]
mymapM f [] = return []
mymapM f (h:t) = do res <- f h
                    rest <- mymapM f t
                    return (res:rest)

--Question 4
whileTrue :: IO Bool -> IO ()
whileTrue s = do ret <- s
                 if ret == True
                   then whileTrue s
                   else return ()

--Question 5
productM :: [Int] -> Int
productM lst =
  evalState (
     do mapM  (\i -> do
           prod <- get 
           put (prod*i)) lst
        prod <- get 
        pure prod
      ) 1
