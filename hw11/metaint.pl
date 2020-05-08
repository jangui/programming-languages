%%%%%%%%%%%%
% DATA SET

a :- b.
b.
c :- a, f, b.
f :- x, y, z.
g :- f.
h :- g.
i :- h.
m :- n, p, q.
n.
p :- f.
q :- z, x, y.
z.
x.
y.
l :- z, x, false.
j :- i, l, m.


%%%%%%%%%%%%
% DFS META-INTERPRETER

solve(true).
solve(false) :- false.
solve(Goal) :-
  Goal \= true, Goal \= false,
  % writeln([solving,Goal]),
  clause(Goal,Body),
  conjunction_to_list(Body,List),
  solve_all(List).

solve_all([]).
solve_all([H|T]) :- solve(H), solve_all(T).

%%%%%%%%%%%%
% BFS META-INTERPRETER

solve_bfs(X) :- bfs([X]).
bfs([]).
bfs([true|T]) :- bfs(T).
bfs([false|_]) :- false.
bfs([Goal|Rest]):-
    Goal \= true, Goal \= false,
    % writeln([solving,Goal]),
    clause(Goal,Body),
    conjunction_to_list(Body,List),
    append(Rest,List,New),
    bfs(New).

%%%%%%%%%%%%
% HELPER CODE

conjunction_to_list((A,B),[A|C]) :- conjunction_to_list(B,C), !.
conjunction_to_list(X,[X]).

% Question 6
solve_reverse(true).
solve_reverse(false) :- false.
solve_reverse(Goal) :-
  Goal \= true, Goal \= false,
  writeln([solving,Goal]),
  clause(Goal,Body),
  conjunction_to_list(Body,List),
  reverse(List, ListReversed),
  solve_all_r(ListReversed).

solve_all_r([]).
solve_all_r([H|T]) :- solve_reverse(H), solve_all_r(T).
