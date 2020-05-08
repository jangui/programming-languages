/*
  Question 7
  "I am never cheese" because our verbphrase can be either adverb followed by verb or just a verb. in this example we see the verbphrase is verb adverb, which is not valid

  no infinite list with the sentence grammar.
longest list would be subject, adverb, verb, [the/a], noun
for ex: "I never is the cheese"
*/

:- use_module(library(tabling)).

:- table expr/3, term/3, paren/3.
paren(Val) --> ['('], expr(Val), [')'].
expr(Val) --> expr(Eval), [+], term(Tval), {Val is Eval+Tval}.
expr(Val) --> expr(Eval), [-], term(Tval), {Val is Eval-Tval}.
expr(Val) --> term(Val).
expr(Val) --> paren(Val).
term(Val) --> term(Tval), [*], primary(Fval), {Val is Tval*Fval}.
term(Val) --> term(Tval), [*], term(Fval), {Val is Tval*Fval}.
term(Val) --> primary(Val).
term(Val) --> paren(Val).
primary(N) --> [N], {integer(N)}.

