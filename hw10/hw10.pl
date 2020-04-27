someTree(X) :-
  X = t("t1",
    t("t2a",
        t("t3a", nil, nil),
        t("t3b", nil, nil)),
    t("t2b",
      t("t3c", nil, nil),
      t("t3d", nil, nil))).

otherTree(X) :-
  X = t("t1",
    t("t2a",
        t("t3a", nil, t("t4b", nil, nil)),
        t("t3b", nil, nil)),
    t("t2b",
      t("t3c", nil, t("t4f", t("5", nil, nil), nil)),
      t("t3d", nil, nil))).
      %t("t3d", t("t4g", nil, t("5", nil, nil)), nil))).

flipNode(nil, nil).
flipNode(t(V, L, R), t(V, R, L)).

% Question 1
getVal(nil, nil).
getVal(t(V, _, _), V).

flipTree(nil, nil).
flipTree(t(V, L, R), t(V, L2, R2)) :- getVal(L, X), getVal(R2, X), getVal(R, Y), getVal(L2, Y), 
                                      flipTree(L, R2), flipTree(R, L2).
% Question 2
inorderTraversalSpatial(t(V, nil, nil), [V]). 
inorderTraversalSpatial(t(V, L, nil), X) :- inorderTraversalSpatial(L, LV), append(LV, [V], X).
inorderTraversalSpatial(t(V, nil, R), X) :- inorderTraversalSpatial(R, RV), append([V], RV, X).
inorderTraversalSpatial(t(V, L, R), X) :- inorderTraversalSpatial(L, LV),
                                          inorderTraversalSpatial(R, RV),
                                          append(LV, [V], Y),
                                          append(Y, RV, X).

% Question 3
inorderTraversalTemporal(t(_, L, _), Res) :- inorderTraversalTemporal(L, Res).
inorderTraversalTemporal(t(V, _, _), V).
inorderTraversalTemporal(t(_, _, R), Res) :- inorderTraversalTemporal(R, Res).

% Question 4
% are the elements in A the first elments of B
sublistfromStart(A, B) :- append(A, _, B).

sublist(A, B) :- sublistfromStart(A, B).
sublist(A, [_|T]) :- sublist(A, T).

% Question 5
sublist_cut(A, B) :- sublistfromStart(A, B),!.
sublist_cut(A, [_|T]) :- sublist(A, T).

/* Question 6
 
a) X = 14

b) X = 14
   X = 24

c) false (X matches to 4, back trapping haulted, 4 fails X > 10)
  
d) false (13 fails mod 2 = 0)

*/

% Question 7
isSorted([H, H2]) :- H =< H2.
isSorted([H, H2 | T]) :- H =< H2, isSorted([H2|T]).

bad_sort([V], [V]).
bad_sort(X, Y) :- permutation(X, Y), isSorted(Y).

% Question 8
graph1([n1-n2, n2-n5, n1-n3, n1-n4, n4-n6, n6-n7, n6-n8]).
graph2([n1-n2, n2-n5, n1-n3, n1-n4, n4-n6, n6-n7, n7-n1, n7-n8]).
graph3([n4-n5, n1-n2, n1-n3, n1-n4, n4-n9, n9-10, n9-n11, n9-n12, n12-n9]).

%traverse graph fully from start point and check if we've visited any node before
isCycle(G, S, Visited) :- member(S-X, G), member(X, Visited),!.
isCycle(G, S, Visited) :- append([S], Visited, Lst), member(S-X, G), isCycle(G, X, Lst).

%from every start point, check if theres a cycle
hasCycle(G) :- member(Y-_, G), isCycle(G, Y, []),!.

















