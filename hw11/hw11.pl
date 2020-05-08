:- use_module(library(clpfd)).

% Question 1
nth_clpfd(0, [X|_], X).
nth_clpfd(N, [_|R], X) :- N1 #= N-1, nth_clpfd(N1, R, X).

% Question 2
sisters(X) :-
  X = [A,B,C,D,E],
  %A in 8..200, B in 8..200, C in 8..200, D in 8..200, E in 8..200,
  A #>= 8, B #>= 8, C #>= 8, D #>= 8, E #>= 8,
  200 #= A + B + C + D + E,
  2*D2 #= D,
  3*E3 #= E,
  200 #= (A*12) + (B*3) + C + D2 + E3,
  label([A,B,C,D,E]).

% Question 3 in shopping.pl

% Question 4
seating :-
  People = [Bob, Sandra, Jiri, Zoltan, Jana, Bogdana],
  People ins 1..6,

  Sandra #\= 1, Sandra #\= 6,
  Zoltan in 1 \/ 6,
  Bogdana #= 3,

  1 #= abs(X), X #= Bob - Jiri,
  1 #< abs(Y), Y #= Zoltan - Bob,
  1 #< abs(Z), Z #= Zoltan - Jana,
  all_different(People),

  label(People),
  writeln(people=People).



% Question 5 %%%%% not finished  %%%%%
% h(name, pet, laptop, course)
profs(Hs) :-
  length(Hs, 5),
  A = h(abel,_,_,distsys), member(A, Hs),
  B = h(biggs,camel,_,_), member(B, Hs), not(nextTo(Hs, B, M)),
  member(h(_,_,thinkpad,introprog), Hs),
  D = h(daniels,_,chromebook,_), member(D, Hs), nextTo(Hs, D, h(_,_,acer,_)),
  M = h(_,snake,macbook,algo), member(M, Hs),
  E = h(eucalpytus,_,_,_), member(E, Hs), nth_clpfd(0, Hs, E),
  Y = h(_,bird,_,L), member(Y, Hs), nth_clpfd(4, Hs, Y), L \= acer,
  F = member(h(_,ferret,_,_)), member(F, Hs), nextTo(Hs, F, B),
  T = h(_,_,toshiba, ai), member(T, Hs),
  nextTo(Hs, T, h(_,capybara,_,_)).

nextTo(Hs, P1, P2) :-
  append(_, [P1,P2|_], Hs).


% Question 6 in metaint.pl

% Questions 7, 8, 9, 10 in parsen.pl
