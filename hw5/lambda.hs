import Text.Parsec (parse, between, try, many1, many, string, anyChar, 
        alphaNum, eof, ParseError, spaces, optional, (<|>))
import Data.List (union, delete)

type VarName = String

data Term = Var VarName      -- a variable, such as "x" or "y"
          | Lam VarName Term -- a lambda function, such as "\x.x"
          | App Term Term    -- a function application, such as "(\x.x) y"
    deriving Show

printReducedTerm :: String -> IO ()
printReducedTerm ts =
    case parseTerm ts of
        Left error -> print error
        Right term -> putStrLn $ showTerm (eval term)

showTerm :: Term -> String
showTerm (Lam s t)  = "\0955" ++ s ++ "."++showTerm t
showTerm (Var s)    = s
showTerm (App x y)  = showL x ++ showR y where
    showL (Lam _ _) = "(" ++ showTerm x ++ ")"
    showL _         = showTerm x
    showR (Var s)   = ' ':s
    showR _         = "(" ++ showTerm y ++ ")"

parseTerm :: String -> Either ParseError Term
parseTerm = parse (between ws eof term) "" where
      term = lam <|> app
      lam = flip (foldr Lam) <$> between lam0 lam1 (many1 v) <*> term
      lam0 = str "\\" <|> str "\0955"
      lam1 = str "->" <|> str "."
      app = foldl1 App <$> many1 ((Var <$> v) <|> between (str "(") (str ")") term)
      v   = many1 alphaNum <* ws
      str = (>> ws) . string
      ws = spaces >> optional (try $ string "--" >> many anyChar)

eval :: Term -> Term
eval (App m a) = 
    case eval m of
        Lam v f -> eval (beta v a f)
        _ -> App m a
eval term = term

newName :: String -> [String] -> String
newName var usedVars = head (filter (\y -> y `notElem` usedVars) possibleVarNames)
    where 
        varBase = filter (\c -> c `notElem` ['0'..'9']) var
        possibleVarNames = map (\n -> varBase ++ show n) [1..] 

freeVars :: Term -> [VarName]
freeVars (Var v) = [v] 
freeVars (Lam vn t) = delete vn (freeVars t)
freeVars (App t1 t2) = freeVars t1 `union` freeVars t2

rename :: VarName -> VarName -> Term -> Term
rename v1 v2 (Var v3) = if v3 == v1 then (Var v2) else (Var v3)
rename v1 v2 (Lam v3 t) = if v3 == v1 then (Lam v3 t) else (Lam v3 (rename v1 v2 t))
rename v1 v2 (App t1 t2) = (App (rename v1 v2 t1) (rename v1 v2 t2))

beta :: VarName -> Term -> Term -> Term
beta v t (Var v2) = if v2 == v then t else (Var v2)
beta v t (App e1 e2) = (App (beta v t e1) (beta v t e2))
beta v t (Lam v2 t2) =
  (Lam (newN) (beta v t expr))
    where freeVs = (freeVars (Lam v2 t2))
          newN = (newName v2 freeVs)
          expr = rename v2 newN t2
