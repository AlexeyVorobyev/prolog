/*
БД по типу ресурса:
	1 - бонусный, 
	2 - редкий, 
	3 - стратегический
*/
type(corn,1).
type(wheat,1).
type(livestock,1).
type(rock,1).
type(banana,1).
type(deer,1).
type(fish,1).
type(crab,1).
type(vine,2).
type(citrus,2).
type(sugar,2).
type(fox,2).
type(quartz,2).
type(marble,2).
type(silver,2).
type(whale,2).
type(horse,3).
type(iron,3).
type(coal,3).
type(nitre,3).

/*
БД по доп. доходу с клетки:
	1 - золото, 
	2 - еда, 
	3 - производство,
	4 - наука,
	5 - культура
*/
resource(corn,2).
resource(wheat,2).
resource(livestock,2).
resource(rock,3).
resource(banana,2).
resource(deer,1).
resource(fish,2).
resource(crab,1).
resource(vine,1).
resource(citrus,2).
resource(sugar,2).
resource(fox,1).
resource(quartz,3).
resource(marble,5).
resource(silver,1).
resource(whale,1).
resource(horse,2).
resource(iron,4).
resource(coal,3).
resource(nitre,2).

/*
БД по улучшению, которое можно построить на клетке:
	1 - ферма, 
	2 - пастбище, 
	3 - каменоломня,
	4 - рудник,
	5 - плантация,
	6 - лагерь,
	7 - рыбацкое судно
*/
improvement(corn,1).
improvement(wheat,1).
improvement(livestock,2).
improvement(rock,3).
improvement(banana,5).
improvement(deer,6).
improvement(fish,7).
improvement(crab,7).
improvement(vine,5).
improvement(citrus,5).
improvement(sugar,5).
improvement(fox,6).
improvement(quartz,4).
improvement(marble,3).
improvement(silver,4).
improvement(whale,7).
improvement(horse,2).
improvement(iron,4).
improvement(coal,4).
improvement(nitre,4).

/*
БД по тому, необходим ли данный ресурс для постройки чуда света:
	1 - да,
	2 - нет
*/
wonder(corn,1).
wonder(wheat,2).
wonder(livestock,2).
wonder(rock,1).
wonder(banana,2).
wonder(deer,2).
wonder(fish,2).
wonder(crab,2).
wonder(vine,2).
wonder(citrus,2).
wonder(sugar,1).
wonder(fox,2).
wonder(quartz,2).
wonder(marble,2).
wonder(silver,2).
wonder(whale,2).
wonder(horse,1).
wonder(iron,2).
wonder(coal,1).
wonder(nitre,2).


/*Вопросы*/
question1(X1):-  write("What type is your resource?"), nl,
				write("1. bonus"), nl,
				write("2. rare"), nl,
				write("3. strategic"), nl,
				read(X1).
				
question2(X2):-  write("Which additional income this resource provides to a cell?"), nl,
				write("1. gold"), nl,
				write("2. food"), nl,
				write("3. production"), nl,
				write("4. science"), nl,
				write("5. culture"), nl,
				read(X2).

question3(X3):-  write("Which improvement you can build on cell with that resource?"), nl,
				write("1. farm"), nl,
				write("2. pasture"), nl,
				write("3. quarry"), nl,
				write("4. mine"), nl,
				write("5. plantation"), nl,
				write("6. camp"), nl,
				write("7. fishing vessel"), nl,
				read(X3).

question4(X4):-  write("Required to build wonder of the world?"), nl,
				write("1. yes"), nl,
				write("2. no"), nl,
				read(X4).


/*Команда, выбрасывающая в контекст длину списка подходящих решений для предиката*/
length_list_of_predicate(Count, Predicate):-
				findall(X, call(Predicate), List),
				length(List, Count).
/*Команда, выбрасывающая в контекст булево значение,
получаемое в резултате сравнения значений сравнения prolog*/
to_boolean(Result, Boolean) :-
    ((Result = (=); Result = (>)) -> Boolean = true ; Boolean = false).
/*Команда выбрасывающая в контекст булево значение, которое говорит,
что количество подходящих решений переданного Predicate больше или равно Value*/
predicate_amount_of_solutions_equal_or_larger_than(Result, Predicate, Value):-
	length_list_of_predicate(Count, call(Predicate)),
	compare(Compare_result, Count, Value),
	to_boolean(Compare_result, Result).

/*Команда находящая все ресурсы, которые соответствуют условиям, описанным внтри этого предиката
В случае если ресурс можно определить за меньщее кол-во вопросов, то ответ выдается сразу.*/
test_smart(X):-
	question1(X1),
	predicate_amount_of_solutions_equal_or_larger_than(
		First_result,
		type(X,X1),
		2
	),
	(First_result -> (
		question2(X2),
		predicate_amount_of_solutions_equal_or_larger_than(
			Second_result,
			(type(X,X1), resource(X,X2)),
			2
		),
		(Second_result -> (
			question3(X3),
			predicate_amount_of_solutions_equal_or_larger_than(
				Third_result,
				(type(X,X1), resource(X,X2), improvement(X,X3)),
				2
			),
			write(Third_result),
			(Third_result -> (
				question4(X4),
				type(X,X1),
				resource(X,X2),
				improvement(X,X3),
				wonder(X,X4)
			);(
				type(X,X1),
				resource(X,X2),
				improvement(X,X3)
			))
		);(
			type(X,X1),
			resource(X,X2)
		))
	);(
		type(X,X1)
	)).

/*Команда запуска теста*/
start_test_smart:- test_smart(X), print(X),nl,fail.