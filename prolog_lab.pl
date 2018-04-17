% Austin Rosenbaum
% CSCI 305 Prolog Lab

% Warmup
mother(M,C):- parent(M,C), female(M).
father(F,C):- parent(F,C), male(F).

% The two must be married to be considered spouses
spouse(M, W):- married(M, W).
spouse(M, W):- married(W, M).

% Child relation is simply the reverse parent relation
child(C, P):- parent(P, C).

% Use the above child rule and add gender for son/daughter
son(S, P):- child(S, P), male(S).
daughter(D, P):- child(D, P), female(D).

% If two people have the same mother and are not the same they can be considered siblings
sibling(C1, C2):- mother(M, C1), mother(M, C2), not(C1=C2).

% Use the above sibling rule and add gender for brother/sister
% The sibling rule also removes the possibility of being ones own brother/sister
brother(B, C):- sibling(B, C), male(B).
sister(S, C):- sibling(S, C), female(S).

% Two rules for each, blood and marriage
% Uncles/Aunts must be siblings of parents (or married to them) and the correct gender
uncle(U, C):- parent(P, C), sibling(U, P), male(U).
uncle(U, C):- parent(P, C), sibling(P, UW), spouse(U, UW), male(U).
aunt(A, C):- parent(P, C), sibling(A, P), female(A).
aunt(A, C):- parent(P, C), sibling(P, AH), spouse(A, AH), female(A).

% Extra credit rule
% Cousin is defined as "a child of one's uncle or aunt"
cousin(C1, C2):- uncle(U, C1), aunt(A, C1), child(C2, U), child(C2, A).

% Use parent rules along with gender specific parent for the following rules
grandparent(GP, C):- parent(P, C), parent(GP, P).
grandfather(GF, C):- parent(P, C), father(GF, P).
grandmother(GM, C):- parent(P, C), mother(GM, P).

% Simply reverse the grandparent rule
grandchild(C, GP):- grandparent(GP, C).

% Use recursion to find any ancestor as far up as they could be
% If the ancestor is not just a parent, they must be the ancestor of ones parent
ancestor(A, D):- parent(A, D).
ancestor(A, D):- parent(P, D), ancestor(A, P).

% Simply reverse the ancestor rule
descendant(D, A):- ancestor(A, D).

% Compare the year both people were born and ensure the older year is less than the younger year
older(O, Y):- born(O, OYear), born(Y, YYear), OYear < YYear.

% Simply reverse the older rule
younger(Y, O):- older(O, Y).

% Use the start date and end date for the regent and compare against the persons birth date
% Check >= to Start for the case of Queen Victoria being the regent the same year she was born
regentWhenBorn(Regent, Person):-
	reigned(Regent, Start, End),
	born(Person, Year),
	Year >= Start,
	Year < End.
