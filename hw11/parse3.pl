% Question 10
:- use_module(library(tabling)).

:- table expr/6, term/3, paren/3, eq/3, equal/3.
expr(Val) --> ['if'], equal(C), ['then'], equal(Val), ['else'], equal(_), {C \= 0}.
expr(Val) --> ['if'], equal(C), ['then'], equal(_), ['else'], equal(Val), {C = 0}.
equal(1) --> equal(L), ['='], eq(R), {L = R}.
equal(0) --> equal(L), ['='], eq(R), {L \= R}.
equal(Val) --> eq(Val).
eq(Val) --> eq(Eval), [+], term(Tval), {Val is Eval+Tval}.
eq(Val) --> eq(Eval), [-], term(Tval), {Val is Eval-Tval}.
eq(Val) --> term(Val).
eq(Val) --> paren(Val).
term(Val) --> term(Tval), [*], primary(Fval), {Val is Tval*Fval}.
term(Val) --> term(Tval), [*], term(Fval), {Val is Tval*Fval}.
term(Val) --> primary(Val).
term(Val) --> paren(Val).
primary(N) --> [N], {integer(N)}.
paren(Val) --> ['('], eq(Val), [')'].
