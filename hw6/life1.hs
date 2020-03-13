import System.Environment
import Control.Concurrent

data Board = Board [[Bool]] deriving Eq

exampleBoard1 :: Board
exampleBoard1 = Board [[False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False],[False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False],[False,False,False,False,False,True,True,True,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False],[False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,True,True,False,False,False,False,False,False,False,False,False,False],[False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,True,False,False,False,False,False,False,False,False,False,False],[False,False,False,False,False,False,True,False,False,False,False,False,False,False,False,False,False,True,False,True,False,False,False,False,False,False,False,False,False,False,False],[False,False,False,False,False,False,True,False,False,False,False,False,False,False,False,False,True,False,False,False,False,False,False,False,False,False,False,False,False,False,False],[False,False,False,False,False,False,True,False,False,False,False,False,False,False,False,False,True,True,False,False,False,False,False,False,False,False,False,False,False,False,False],[False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False],[False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False],[False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False],[False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False],[False,False,False,False,False,False,False,False,False,False,True,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False],[False,False,False,False,False,False,False,False,False,False,False,True,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False],[False,False,False,False,False,False,False,False,False,True,True,True,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False],[False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,True,True,False,False,False,False,False],[False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,True,True,False,False,False,False,False],[False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False],[False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False],[False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False],[False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False]]

exampleBoard2 :: Board
exampleBoard2 = Board [[False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False],[False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False],[False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False],[False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False],[False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False],[False,False,False,False,False,False,False,False,True,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False],[False,False,False,False,False,False,False,True,False,True,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False],[False,False,False,False,False,False,True,False,False,False,True,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False],[False,False,False,False,False,False,False,True,True,True,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False],[False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False],[False,False,False,False,False,True,True,False,False,False,True,True,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False],[False,False,False,True,False,False,False,True,False,True,False,False,False,True,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False],[False,False,True,True,False,False,False,True,False,True,False,False,False,True,True,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False],[False,True,False,False,False,False,False,True,False,True,False,False,False,False,False,True,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False],[False,False,True,False,True,True,False,True,False,True,False,True,True,False,True,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False],[False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False],[False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False],[False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False],[False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False],[False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False],[False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False,False]]

instance Show Board where
  show board = printBoard board

printBoard :: Board -> String
printBoard (Board b) = showGrid (map (map (bool2char)) b)

bool2char :: Bool -> Char
bool2char b =
  case b of
    True -> 'O'
    False -> ' '

showGrid :: [String] -> String
showGrid [] = ""
showGrid (h:t) = h ++ "\n" ++ (showGrid t) 

--using functions from hw4 solutions
step :: Board -> Board
step (Board grid) = Board [[let (er,ec) = effectivePos (Board grid) (r,c)
      in rules (grid !! er !! ec) (countNeighbors (Board grid) (er, ec))
      | c<-[0..length (head grid)-1]] | r<-[0..length grid -1]]
    where rules True count | count == 2 || count == 3 = True
          rules False count | count == 3 = True
          rules _ _ = False

countNeighbors :: Board -> (Int, Int) -> Int
countNeighbors (Board grid) (r, c) = sum $ map (\(rb, cb) -> if grid !! rb !! cb then 1 else 0) pos
    where pos = [effectivePos (Board grid) (r+ra,c+ca) | ra<-[-1 .. 1], ca<-[-1 .. 1], ca/=0 || ra/=0]

effectivePos :: Board -> (Int, Int) -> (Int, Int)
effectivePos (Board grid) (r, c) = (newR, newC)
  where newR = wrapTo r gridRows
        newC = wrapTo c gridCols
        gridRows = length grid
        gridCols = length (head grid)
        wrapTo x high =
          case x `mod` high of
            a | a < 0 -> high + a
            a -> a

displayBoard :: Board -> IO ()
displayBoard b = do 
                    putStr "\ESC[2J\ESC[1;1H"
                    putStr $ show b

readLifeFile :: FilePath -> IO Board
readLifeFile fp = do s <- readFile fp
                     return (Board (str2bool (lines s)))


str2bool :: [String] -> [[Bool]]
str2bool [] = []
str2bool (h:t) = (map char2bool h) : str2bool t

char2bool :: Char -> Bool
char2bool c = if c == 'O'
                then True
                else False

main :: IO ()
main = do
  args <- getArgs
  if length args /= 1
    then do putStrLn "usage error!\n   usage: ./life1 [filename]"
    else do board <- readLifeFile $ args!!0
            iter $ return $ board
            return ()

iter :: IO (Board) -> IO (Board)
iter s = do b <- s
            displayBoard b
            threadDelay 500000
            iter $ return $ step b
