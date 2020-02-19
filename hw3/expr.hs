import Text.Parsec.String (Parser)
import qualified Text.Parsec.Char as P (oneOf, char, digit, string)
import qualified Text.Parsec.Combinator as P (many1, eof, chainl1,option,between)
import Control.Applicative ((<$>), (<*>), (<*), (*>), (<|>), many)
import qualified Text.Parsec as P (parse, try)

-- |Converts strings into abstract syntax trees. For example:
--    *Main> exprParser "if (if iszero 3 then iszero 9 else iszero 0) then 4 else 0"
--    Just (ExprIf (ExprIf (ExprIsZero (ExprInt 3)) (ExprIsZero (ExprInt 9)) (ExprIsZero (ExprInt 0))) (ExprInt 4) (ExprInt 0))
-- Returns nothing if the expression cannot be parsed. Does _not_ do type checking or evaluation.
-- You don't need to understand how this function works, as it's a bit outside the scope of
-- the class, but if you're curious, it uses the Parsec parser combinator library:
--     https://hackage.haskell.org/package/parsec
exprParser :: String -> Maybe Expr
exprParser s = 
    case P.parse (exprP <* P.eof) "" s of
        Right x -> Just x
        Left _ -> Nothing
    where exprP = termP `P.chainl1` addOp <* whitespace
          termP = intP <|> boolP <|> P.try ifthenelseP <|> iszeroP <|> parensP
          ifthenelseP = P.string "if" *> whitespace>>ExprIf <$> exprP <*> 
              (P.string "then" *>whitespace *> exprP) <*> 
              (P.string "else" *> whitespace *> exprP)  
          iszeroP = P.string "iszero" >>whitespace>> ExprIsZero <$> exprP
          addOp = (infixOp "+" (ExprOp Add)) <|> (infixOp "-" (ExprOp Subtract))
          infixOp :: String -> (a -> a -> a) -> Parser (a -> a -> a)
          infixOp x f = P.string x >> return f
          intP = ExprInt <$> read <$> lexeme ((++) <$> (P.option "" (P.string "-")) <*> P.many1 P.digit)
          parensP = P.between (P.char '(') (P.char ')') exprP
          boolP = ExprBool <$> read <$> lexeme (P.string "True" <|> P.string "False")
          whitespace = (many $ P.oneOf " \n\t") >> pure ()
          lexeme p = p <* whitespace

-- |Represents the two binary operations
-- understood by our toy language, add and
-- subtract
data Operation = Add | Subtract
    deriving (Eq, Show)

-- |Represents an abstract syntax tree
-- of an expression. Each of these
-- constructors represents a different
-- kind of expression.
data Expr = ExprInt Int
          -- ^ an integer literal, such as 5  
          | ExprBool Bool
          -- ^ a boolean literal, such as True
          | ExprOp Operation Expr Expr
          -- ^ an binary arithmetic expression,
          -- such as 3+4
          | ExprIsZero Expr
          -- ^ a "comparison-to-zero" test, such
          -- as iszero (3-4)
          | ExprIf Expr Expr Expr
          -- ^ a conditional expression, consisting
          -- of a condition, an if clause and an
          -- else clause, such as:
          --  if iszero (3-3) then 9 else 4
          deriving (Eq, Show)

data Type = TypeInt | TypeBool
    deriving (Eq,Show)

-- |Perform typecheck on a given expression
-- and returns Just TypeInt or Just TypeBool
-- in the event of consistent typing, and
-- returns Nothing in the case of a typing
-- error. For example,
--   ExprOp Add (ExprInt 3) (ExprBool True)
-- is a type error, because you can't add
-- an int to a bool.
typecheck :: Expr -> Maybe Type
typecheck (ExprInt _) = 
    {-An integer literal typechecks as an integer-}
    Just TypeInt
typecheck (ExprBool _) = 
    {-A boolean literal typechecks as a bool-}
    Just TypeBool
typecheck (ExprOp op e1 e2) =
    {-An arithmetic expression typechecks as an int,
    if both operands are integer expressions, otherwise
    it's badly typed-}
    case typecheck e1 of
        Just TypeInt -> 
            case typecheck e2 of
                Just TypeInt -> Just TypeInt
                _ -> Nothing
        _ -> Nothing
typecheck (ExprIsZero expr) =
    Nothing -- TODO
    {-Perform type check on an IsZero expressions, whose argument must evaluate to integer-}
typecheck (ExprIf condition ifexpr elseexpr) =
    Nothing -- TODO
    {-Perform type check on an If expressions. The condition must be a boolean
    expression, and both the if clause and else clause must be of the same type -}

-- |Call this function to test your typecheck function
test_typecheck :: String
test_typecheck =
    case filter (passes . snd) (zip [0..] tests) of
        [] -> "All tests passed"
        x -> "Failed tests: " ++ concatMap showResult x
    where
        showResult (num, (expr, expect)) =
            "in test: "++show num++", got " ++ show (typecheck expr) ++ " but expected " ++ show expect++"; "
        passes (expr, expected) =
            typecheck expr /= expected
        tests = {-test 0-} [(ExprInt 0, Just TypeInt),
                {-test 1-} (ExprOp Add (ExprInt 0) (ExprBool False), Nothing),
                {-test 2-} (ExprOp Add (ExprInt 0) (ExprInt 1), Just TypeInt),
                {-test 3-} (ExprIsZero (ExprInt 0), Just TypeBool),
                {-test 4-} (ExprIf (ExprInt 0) (ExprInt 0) (ExprInt 0), Nothing),
                {-test 5-} (ExprIf (ExprBool True) (ExprIsZero (ExprInt 0)) (ExprInt 0), Nothing),
                {-test 6-} (ExprIf (ExprIf (ExprBool True) (ExprBool True) (ExprBool True)) (ExprIf (ExprBool True) (ExprInt 4) (ExprInt 3)) (ExprIf (ExprBool True) (ExprInt 0) (ExprInt 1)), Just TypeInt)
                ]  

data EvalResult = ResultInt Int | ResultBool Bool | ResultError
    deriving (Eq,Show)

-- |Given an expression, produce a result (either an int or a bool)
-- or ResultError if the expression is invalid.
-- This functions does a typecheck first, so you can assume that
-- the expressions are well-typed 
eval :: Expr -> EvalResult
eval ev =
    case typecheck ev of
        Nothing -> ResultError
        _ -> step ev
    where 
        step (ExprInt i) = ResultInt i
        step (ExprBool b) = ResultBool b
        step (ExprOp op e1 e2) =
            ResultInt 0 -- TODO
            {-Produce an ResultInt equal to the sum
            of the expressions e1 and e2 -}
        step (ExprIsZero expr) =
            ResultBool False -- TODO
            {-Produce a ResultBool True if the integer expression
              is equal to zero, or ResultBool False if it isn't -}
        step (ExprIf condition ifpart elsepart) =
            ResultBool False -- TODO
            {-Returns the value of the ifpart expression if
              cond evaluates to true, or elsepart otherwise-}

-- |Call this function to test your eval function
test_eval :: String
test_eval =
    case filter (passes . snd) (zip [0..] tests) of
        [] -> "All tests passed"
        x -> "Failed tests: " ++ concatMap showResult x
    where
        showResult (num, (expr, expect)) =
            "in test: "++show num++", got " ++ show (eval expr) ++ " but expected " ++ show expect++"; "
        passes (expr, expected) =
            eval expr /= expected
        tests = {-test 0-} [(ExprInt 0, ResultInt 0),
                {-test 1-} (ExprOp Add (ExprInt 0) (ExprBool False), ResultError),
                {-test 2-} (ExprOp Add (ExprInt 2) (ExprInt 1), ResultInt 3),
                {-test 3-} (ExprIsZero (ExprInt 0), ResultBool True),
                {-test 4-} (ExprIf (ExprIsZero (ExprInt 0)) (ExprOp Subtract (ExprInt 6) (ExprInt 1)) (ExprInt 9), ResultInt 5)]  

