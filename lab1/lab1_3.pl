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