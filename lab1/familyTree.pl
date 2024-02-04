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
