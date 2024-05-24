/**
    Функция просчёта пересечения двух листов
    lists_intersection(+FirstList,+SecondList,-ResultList)
*/
lists_intersection(FirstList, SecondList, ResultList):-
    list_intersection_internal(FirstList, SecondList, ResultList).

/**
    Функция просчёта пересечения двух листов рекурсией вверх
    lists_intersection_internal(+FirstList,+SecondList,-ResultList)
*/
list_intersection_internal([],SecondList,ResultList):-
    ResultList = [].

/**
    Функция сравнения для includes
    lists_intersection(+Goal,+Xi)
*/
is_equal(Goal,Xi):- Goal =:= Xi.

/**
    Функция просчёта пересечения двух листов рекурсией вверх
    lists_intersection_internal(+FirstList,+SecondList,-ResultList)
*/
list_intersection_internal([H|T],SecondList,ResultList):-
    include(is_equal(H),SecondList,IncludedList),
    length(IncludedList,IncludedListLength),
    (IncludedListLength >= 1 -> (
        list_intersection_internal(T,SecondList,NewResultList),
        append(NewResultList, [H], ResultList)
    );(
        list_intersection_internal(T,SecondList,NewResultList),
        ResultList = NewResultList
    )).


/**
    Предикат подсчёта делителей числа в список
    calc_dividers_amount(+Number, -DividersList) is det
*/
calc_dividers_list(Number, DividersList):-
    numlist(1, Number, List),
    calc_dividers_list_internal(Number, List, [], DividersList).

/**
    Предикат выхода из рекурсии и унификации DividersList
    calc_dividers_amount_internal(+Number, +List, +DividersListAcc, -DividersList) is det
*/
calc_dividers_list_internal(Number, [], DividersListAcc, DividersList):-
    DividersList = DividersListAcc.

/**
    Предикат рекуррентного перебора листа рекурсией вниз
    calc_dividers_list_internal(+Number,+List, +DividersListAcc, -DividersList) is det
*/
calc_dividers_list_internal(Number, [H|T], DividersListAcc, DividersList):-
    (Number mod H =:= 0 ->(
        append(DividersListAcc, [H], NewDividersListAcc),
        calc_dividers_list_internal(Number,T,NewDividersListAcc, DividersList)
    );(
        calc_dividers_list_internal(Number,T,DividersListAcc, DividersList)
    )).


/**
    Функция поодсчёта количества взаимоПростых чисел к заданному
    find_amount_of_digits_primary_to(+Number, ?Amount) is det
*/
find_amount_of_digits_primary_to(Number, Amount):-
     numlist(1, 100, NumbersToCompareList),
     calc_dividers_list(Number,NumberDividersList),
     find_amount_of_digits_primary_to_internal(NumberDividersList, NumbersToCompareList, Amount).

/**
    Функция подсчёта количества взаимоПростых чисел к заданному рекурсией вверх
    Выход из рекурсии
    find_amount_of_digits_primary_to_internal(+NumberDividersList, +NumbersToCompareList, ?Amount) is det
*/
find_amount_of_digits_primary_to_internal(_,[],Amount):-
    Amount is 0.
/**
    Функция подсчёта количества взаимоПростых чисел к заданному рекурсией вверх
    find_amount_of_digits_primary_to_internal(+NumberDividersList, +NumbersToCompareList, ?Amount) is det
*/
find_amount_of_digits_primary_to_internal(NumberDividersList,[H|T],Amount):-
    calc_dividers_list(H,CurrentNumberDividersList),
    lists_intersection(NumberDividersList, CurrentNumberDividersList, IntersectedList),
    length(IntersectedList,IntersectedListLength),
    (IntersectedListLength =:= 1 -> (
        find_amount_of_digits_primary_to_internal(NumberDividersList,T,NewAmount),
        Amount is 1 + NewAmount
    );(
        find_amount_of_digits_primary_to_internal(NumberDividersList,T,NewAmount),
        Amount is NewAmount
    )).

/**ЗАДАНИЕ 5.1-------------------------------------*/

find_nod(FirstNumber, 0, FirstNumber).
/**
 Функция поиска НОД между двумя числами
 find_nod(+FirstNumber,+SecondNumber,?Nod)
*/
find_nod(FirstNumber,SecondNumber,Nod):-
    SecondNumber \= 0,
    ModResult is FirstNumber mod SecondNumber,
    find_nod(SecondNumber, ModResult, Nod).

/**
    Функция поодсчёта количества взаимоПростых чисел к заданному
    find_amount_of_digits_primary_to_easy(+Number, ?Amount) is det
*/
find_amount_of_digits_primary_to_easy(Number, Amount):-
     numlist(1, Number, NumbersToCompareList),
     find_amount_of_digits_primary_to_easy_internal(Number, NumbersToCompareList, Amount).

/**
    Функция подсчёта количества взаимоПростых чисел к заданному рекурсией вверх
    Выход из рекурсии
    find_amount_of_digits_primary_to_internal(+NumberDividersList, +NumbersToCompareList, ?Amount) is det
*/
find_amount_of_digits_primary_to_easy_internal(_,[],0).
/**
    Функция подсчёта количества взаимоПростых чисел к заданному рекурсией вверх
    find_amount_of_digits_primary_to_easy_internal(+NumberDividersList, +NumbersToCompareList, ?Amount) is det
*/
find_amount_of_digits_primary_to_easy_internal(Number,[H|T],Amount):-
    find_nod(Number, H, Nod),
    (Nod =:= 1 -> (
        find_amount_of_digits_primary_to_easy_internal(Number, T, NewAmount),
        Amount is NewAmount + 1
    );(
        find_amount_of_digits_primary_to_easy_internal(Number, T, NewAmount),
        Amount is NewAmount
    )).

/**ЗАДАНИЕ 5.2-------------------------------------*/
%Найти делитель числа,
%являющийся взаимно простым с наибольшим количеством
%цифр данного числа.

/**
 Преобразовывает число с список чисел
*/
number_to_digits(0, [0]).
number_to_digits(N, Digits) :-
    N > 0,
    number_to_digits_helper(N, Digits).

number_to_digits_helper(0, []).
number_to_digits_helper(N, Digits) :-
    N > 0,
    NextDigit is N mod 10,
    Rest is N // 10,
    number_to_digits_helper(Rest, RestDigits),
    append(RestDigits, [NextDigit], Digits).

/**
    Критерий Взаимной простоты
    self_primary_criteria(+ToCompare,+Xi) is failure
*/
self_primary_criteria(ToCompare,Xi):-
    find_nod(ToCompare, Xi, Nod),
    Nod =:= 1.

/**
    find_divider_specific(+Number,?Divider) is det
*/
find_divider_specific(Number,Divider):-
    calc_dividers_list(Number,DividersList),
    number_to_digits(Number, DigitsList),
    find_divider_specific_internal(DividersList,DigitsList,Divider).

find_divider_specific_internal([H|[]],_,H).

/**
    find_divider_specific_internal(+DividersList,+DigitsList,?Divider) is det
*/
find_divider_specific_internal([H|T],DigitsList,Divider):-
    find_divider_specific_internal(T,DigitsList,NewDivider),
    include(self_primary_criteria(H),DigitsList,PrimaryToHList),
    length(PrimaryToHList,PrimaryToHListLength),
    include(self_primary_criteria(NewDivider),DigitsList,PrimaryToNewDividerList),
    length(PrimaryToNewDividerList,PrimaryToNewDividerListLength),
    (PrimaryToNewDividerListLength < PrimaryToHListLength, H \= 1 -> (
        Divider is H
    );(
        Divider is NewDivider
    )).





