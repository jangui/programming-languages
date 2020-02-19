{-
 - Jaime Danguillecourt
 - jd3846
 - Hw 2
-}
import Data.Char (toUpper)

-- Question 1
-- Question 2
-- Question 3

-- Question 4
stutterN :: Int -> [a] -> [a]
stutterN 0 (h:t) = []
stutterN n [] = []
stutterN n (h:t) = repeatN n h ++ stutterN n t

repeatN :: Int -> a -> [a]
repeatN 0 a = []
repeatN n a = a : repeatN (n-1) a

-- Question 5
{-
 - a) return value: [True, False, True, False]
 -    return type: [Bool]
 -
 - b) return value: "1212"
 -    return type: String
 -
 - c) return value: [64]
 -    return type: [Int]
 -
 - d) Int -> Int -> Int
 - e) (Int -> Int) -> Int -> Int
 -
-}

-- Question 6
onlyVowelsToUppercase :: String -> String
onlyVowelsToUppercase "" = ""
onlyVowelsToUppercase s = filter (isUpperVowel) (map (toUpper) s)

isUpperVowel :: Char -> Bool
isUpperVowel c = (c `elem` "AEIOU")

-- Question 7
length2 :: [a] -> Int
length2 lst = foldl (\acc _ -> acc + 1) 0 lst

-- Question 8
uniq :: [Char] -> [Char]
uniq "" = ""
uniq (h:t) =
  if h `elem` t
    then uniq (h : filter (\c -> c /= h) t)
    else h : uniq t

-- Question 9
applyList :: [a -> b] -> a -> [b]
applyList [] a = []
applyList (h:t) a = [(h a)] ++ applyList t a 

-- Question 10
mostOdds :: [[Int]] -> [Int]
mostOdds lst = foldl (\acc item -> if (countOdds(item) > countOdds(acc)) then item else acc) [] lst

countOdds :: [Int] -> Int
countOdds lst = foldl (countOddHelper) 0 (map odd lst)

countOddHelper :: Int -> Bool -> Int
countOddHelper acc item =
  if item == True
    then acc + 1
    else acc

-- Question 11
type Grid = [[Char]]

grid1 :: Grid
grid1 = ["BXHPBLACK","BGOIEFWFI", "NYQNPDHAQ","QGTKGREEN","WHITEBLUE","ORANGEGUX","UBLYELLOW","KXMGZPDRR","BROWNTRED"]

grid2 :: Grid
grid2 = ["ZGNSTUDENTLVQ","PDOSAYUAJEIGU","YETELXAOYGHUE","QJECLUSKOOCEF","WUBEEJNSTGRRR","RUOREHCAETAAK","IROXJIXTHQESR","TPKOWJPBMBSEE","IMAMDEZHUDERL","NALPNIGZTMRXU","GTKCERMLBNLGR","RHILGRGNIDAER","PLAYGROUNDREI"]

wordDict = ["ZGNSTUDENTLVQ","PDOSAYUAJEIGU","YETELXAOYGHUE","QJECLUSKOOCEF","WUBEEJNSTGRRR","RUOREHCAETAAK","IROXJIXTHQESR","TPKOWJPBMBSEE","IMAMDEZHUDERL","NALPNIGZTMRXU","GTKCERMLBNLGR","RHILGRGNIDAER","PLAYGROUNDREI"]

--findAll :: [String] -> Grid -> [String]

transposeGrid :: Grid -> Grid
transposeGrid grid =  
