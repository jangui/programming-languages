test1 :-
    Letters = [r,a,b,o,t,l,y],
    doSpellingBee(Letters, Word),
    atom_chars(AtomWord,Word),write(AtomWord),nl,
    fail.

test2 :-
    Letters = [t,e,v,o,q,m,n],
    doSpellingBee(Letters, Word),
    atom_chars(AtomWord,Word),write(AtomWord),nl,
    fail.

test3 :-
    Letters = [n,t,o,y,u,l,g],
    doSpellingBee(Letters, Word),
    atom_chars(AtomWord,Word),write(AtomWord),nl,
    fail.

readWord(InStream,W):-
     get_char(InStream,Char),
     checkCharAndReadRest(Char,W,InStream).

checkCharAndReadRest('\n',[],_):- !.
checkCharAndReadRest(' ',[],_):- !.
checkCharAndReadRest(end_of_file,[],_):- !.
checkCharAndReadRest(Char,[Char|Chars],InStream):-
     get_char(InStream,NextChar),
     checkCharAndReadRest(NextChar,Chars,InStream). 

readWordStream(Str,[]) :- at_end_of_stream(Str), !.
readWordStream(Str,[Word|Words]) :- readWord(Str,Word), readWordStream(Str,Words).

readDict(Words) :-
         open('spellingbee.txt',read,Str),
         readWordStream(Str,Words),
         close(Str).

% is a word composed of only the letters in the list

% every element in the 2nd list is part of the 1st list
composedOf(_, []).
composedOf(Letters, [H|T]) :- memberchk(H, Letters), composedOf(Letters, T).

doSpellingBee([H|T], Word) :-
  readDict(Words), member(Word, Words), length(Word, L), L > 3,
  memberchk(H, Word), composedOf([H|T], Word).
