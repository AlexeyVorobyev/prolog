man(voeneg).
man(ratibor).
man(boguslav).
man(velerad).
man(duhovlad).
man(svyatoslav).
man(dobrozhir).
man(bogomil).
man(zlatomir).

woman(goluba).
woman(lubomila).
woman(bratislava).
woman(veslava).
woman(zhdana).
woman(bozhedara).
woman(broneslava).
woman(veselina).
woman(zdislava).

parent(voeneg,ratibor).
parent(voeneg,bratislava).
parent(voeneg,velerad).
parent(voeneg,zhdana).

parent(goluba,ratibor).
parent(goluba,bratislava).
parent(goluba,velerad).
parent(goluba,zhdana).

parent(ratibor,svyatoslav).
parent(ratibor,dobrozhir).
parent(lubomila,svyatoslav).
parent(lubomila,dobrozhir).

parent(boguslav,bogomil).
parent(boguslav,bozhedara).
parent(bratislava,bogomil).
parent(bratislava,bozhedara).

parent(velerad,broneslava).
parent(velerad,veselina).
parent(veslava,broneslava).
parent(veslava,veselina).

parent(duhovlad,zdislava).
parent(duhovlad,zlatomir).
parent(zhdana,zdislava).
parent(zhdana,zlatomir).

/*Задание 1*/

/*Предикат вывода всех мужчин*/
men():- man(X), print(X), nl, fail.

/*Предикат вывода всех женщин*/
women():- woman(X), print(X), nl, fail.

/*Предикат вывода всех детей X*/
children(X):- parent(X,Y), print(Y), nl, fail.

/*Предикат, определяющий то, что X - мать Y*/
mother(X,Y):- woman(X), parent(X,Y).
/*Предикат вывода матерей X*/
mother(X):- mother(Y,X), print(Y), nl, fail.

/*Предикат,определяющий то, что X - брат Y*/
brother(X,Y):- 
	man(X), 
	once((
		parent(Z,X), 
		parent(Z,Y)
		))
	, X \= Y.
/*Предикат, выводящий всех братьев X*/
brothers(X):- brother(Y,X), print(Y), nl, fail.

/*Предикат, определяющий то, что X - сиблинг Y*/
s_b(X,Y):- 
		parent(Z,X), 
		parent(Z,Y),
		X \= Y.
/*Предикат выводящий всех сиблингов X*/
s_b(X):- s_b(Y,X), print(Y), nl, fail.


/*Задание 2*/


/*Предикат, проверяющий является ли X - сыном Y*/
son(X,Y):- man(X), parent(Y,X).
/*Предикат, выводящий сына X*/
son(X):- son(Y,X) -> print(Y).

/*Предикат, проверяющий является ли X - сестрой Y*/
sister(X,Y):-
	woman(X),
	parent(Z,X),
	parent(Z,Y),
	X \= Y.
/*Предикат, выводящий всех сестёр X*/
sisters(X):- sister(Y,X), print(Y), nl, fail.


/*Задание 3*/


/*Предикат, проверяющий является ли X - бабушкой Y*/
grand_ma(X,Y):-
	woman(X),
	parent(X,Z),
	parent(Z,Y).
/*Предикат, выводящий всех бабушек X*/
grand_mas(X):- grand_ma(Y,X), print(Y), nl, fail.

/*Предикат, проверяющий является ли X,Y - дедом и внуком или внуком и дедом*/
grand_pa_and_son(X,Y):-
	man(X),
	man(Y),
	(
		parent(X,Z),
		parent(Z,Y);
		parent(Y,Z),
		parent(Z,X)
	).

/*Предикат, определяющий то, что X - сиблинг Y*/
sibling(X,Y):-
	parent(Z,X),
	parent(Z,Y),
	X \= Y.
/*Предикат, проверяющий является ли X - дядей Y*/
uncle(X,Y):-
	man(X),
	parent(Z,Y),
	sibling(X,Z).
/*Предикат, проверяющий является ли X - дядей Y,
но без использования готового предиката*/
uncle_ry(X,Y):-
	man(X),
	parent(Z,Y),
	parent(W,X),
	parent(W,Z),
	X \= Z.
/*Предикат, выводящий всех дядей X*/
uncle(X):- uncle(Y,X), print(Y), nl, fail.


%/**Brother**/
%brother(X,Y):-
%	man(X),
%	parent(Z,X),
%	parent(Z,Y),
%	X \= Y.

couple(X,Y):-
    parent(X,Z),
    parent(Y,Z),
    X\= Y.

/*Предикат, выводящий
у меня есть брат у него есть жена у ней есть бабулю
вывести бабулю жены брата
*/
%X - Я
%Y - брат
%Z - жена
%I - бабка жены
what(X, I):-
    brother(Y, X),
    couple(Y,Z),
    grand_ma(I,Z).

what_find(I):- what(X,I).