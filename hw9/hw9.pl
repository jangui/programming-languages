/*
Jaime Danguillecourt
jd3846
HW9

Question 1

E is true if C and D are True.
C is true if A and B are True.
A and B are both true because they are each facts.
Therefore C is true.
D is true becaues it is a fact.
Therefor E is true.

E is also true if G is True.
But G's truth depends on F which we known nothing about

Regardless, E was already made true from the first horn clause.

Question 2
a) true
b) true
c) false
d) false
e) true
f) false
g) false

*/

% Question 8
inboth([X|_], [X|_], X).
inboth([X|T], [_|T2], X) :- inboth([X|T], T2, X).
inboth([_|T], [X|T2], X) :- inboth(T, [X|T2], X).
inboth([_|T], [_|T2], X) :- inboth(T, T2, X).

% Question 9
increment_all([], []).
increment_all([H|T], [I|T2]) :- I is H+1, increment_all(T, T2).

% Question 10
foldup(X, X).
foldup([H, H2 | T], L) :- S is H + H2, foldup([S|T], L).

/* Question 11
T1 = [[a, f(b), c, d], g(X1, [e|X2]), X3, X4|X5]
T2 = [Y1, g(d, Y2) | Y1]

Y1 needs to unify with [a, f(b), c, d].
Y1 = [a, f(b), c, d]

g(X1, [e|X2]) needs to unify with g(d, Y2)
so X1 needs to unify with d and [e|X2] needs to unify with Y2
X1 = d
Y2 = [e|X2]

[X3, X4 | X5] needs to unify with Y1. Therefore X3 = a, X4 = f(b), X5 = [c,d] 

No constraints we're met in the unification so T1 does unify to T2 with the specified values.
*/

% Question 12
all_diff([]).
all_diff([H|T]) :- all_diff(T), not(member(H, T)).

% Question 13
splitAt(Pos, List, A, B) :- append(A, B, List), length(A, Pos).
