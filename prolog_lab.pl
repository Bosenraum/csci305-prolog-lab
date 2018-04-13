% Austin Rosenbaum
% CSCI 305 Prolog Lab

mother(M,C):- parent(M,C), female(M).
father(F,C):- parent(F,C), male(F).

spouse(M, W):- married(M, W).
spouse(M, W):- married(W, M).

child(C, P):- parent(P, C).

son(S, P):- child(S, P), male(S).
daughter(D, P):- child(D, P), female(D).

%sibling(C1, C2):- father(F, C1), father(F, C2), not(C1=C2).
sibling(C1, C2):- mother(M, C1), mother(M, C2), not(C1=C2).

brother(B, C):- sibling(B, C), male(B).
sister(S, C):- sibling(S, C), female(S).

uncle(U, C):- parent(P, C), sibling(U, P), male(U).
uncle(U, C):- parent(P, C), sibling(P, UW), spouse(U, UW), male(U).
aunt(A, C):- parent(P, C), sibling(A, P), female(A).
aunt(A, C):- parent(P, C), sibling(P, AH), spouse(A, AH), female(A).

grandparent(GP, C):- parent(P, C), parent(GP, P).
grandfather(GF, C):- parent(P, C), father(GF, P).
grandmother(GM, C):- parent(P, C), mother(GM, P).
grandchild(C, GP):- grandparent(GP, C).

ancestor(A, D):- parent(A, D).
ancestor(A, D):- parent(P, D), ancestor(A, P).

descendant(D, A):- ancestor(A, D).

older(O, Y):- born(O, OYear), born(Y, YYear), OYear < YYear.
younger(Y, O):- older(O, Y).

regentWhenBorn(Regent, Person):-
	reigned(Regent, Start, End),
	born(Person, Year),
	Year >= Start,
	Year < End.
