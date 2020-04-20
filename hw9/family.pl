male(bob).
male(john).
male(ben).
male(martin).
male(edmund).
male(david).
male(isidore).
male(william).
male(ferdinand).
male(morris).
male(alphonse).
male(jiri).
female(kathryn).
female(beatrice).
female(rachel).
female(lillian).
female(alice).
female(rosa).
female(marjorie).
female(emma).
female(nellie).
female(eva).
female(bertha).
female(fergie).

% A is the child of B
child(bob, john).
child(bob, kathryn).

child(beatrice, john).
child(beatrice, kathryn).

child(john, ben).
child(john, rachel).
child(lillian, ben).
child(lillian, rachel).

child(kathryn, rosa).
child(kathryn, martin).
child(alice, martin).
child(alice, rosa).
child(ferdinand, martin).
child(ferdinand, fergie).

child(marjorie, edmund).
child(marjorie, lillian).
child(david, lillian).
child(david, edmund).

child(ben, isidore).
child(ben, bertha).
child(william, isidore).
child(william, bertha).
child(emma, isidore).
child(emma, bertha).

child(morris, alphonse).
child(morris, emma).
child(nellie, alphonse).
child(nellie, emma).
child(eva, alphonse).
child(eva, emma).
child(jiri, alphonse).
child(jiri, emma).

% A is the father of B
father(A, B) :- male(A), child(B, A).

% A is the mother of B
mother(A, B) :- female(A), child(B, A).

% A & B are siblings
sibling(A, B) :- father(C, A), child(B, C), B \= A.
sibling(A, B) :- mother(C, A), child(B, C), B \= A.

% A is uncle of B
uncle(A, B) :- male(A), father(C, B), sibling(A, C).
uncle(A, B) :- male(A), mother(C, B), sibling(A, C).

% A is aunt of B
aunt(A, B) :- male(A), father(C, B), sibling(A, C).
aunt(A, B) :- male(A), mother(C, B), sibling(A, C).

% A is ancestor of B
ancestor(A, B) :- father(A, B).
ancestor(A, B) :- mother(A, B).
ancestor(A, B) :- father(X, B), ancestor(A, X).
ancestor(A, B) :- mother(X, B), ancestor(A, X).

% A is first cousin of B
first_cousin(A, B) :- uncle(X, A), father(X, B).
first_cousin(A, B) :- aunt(X, A), mother(X, B).

