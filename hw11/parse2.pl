% Question 9
:- use_module(library(tabling)).

:- table expr/3, term/3, paren/3, eq/3.
paren(Val) --> ['('], eq(Val), [')'].
expr(1) --> expr(L), ['='], eq(R), {L = R}.
expr(0) --> expr(L), ['='], eq(R), {L \= R}.
eq(Val) --> eq(Eval), [+], term(Tval), {Val is Eval+Tval}.
eq(Val) --> eq(Eval), [-], term(Tval), {Val is Eval-Tval}.
eq(Val) --> term(Val).
eq(Val) --> paren(Val).
expr(Val) --> eq(Val).
term(Val) --> term(Tval), [*], primary(Fval), {Val is Tval*Fval}.
term(Val) --> term(Tval), [*], term(Fval), {Val is Tval*Fval}.
term(Val) --> primary(Val).
term(Val) --> paren(Val).
primary(N) --> [N], {integer(N)}.
