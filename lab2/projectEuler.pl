
/**
    Предикат подсчёта делителей числа в список
    calc_dividers_amount(+Number, -DividersList) is det
*/
calc_dividers_list(Number, DividersList):-
    Square is round(sqrt(Number)),
    numlist(2, Square, List),
    calc_dividers_list_internal(Number, List, DividersList).

/**
    Предикат выхода из рекурсии и унификации DividersList
    calc_dividers_amount_internal(+Number, +List, -DividersList) is det
*/
calc_dividers_list_internal(Number, [], [1,Number]).
/**
    Предикат рекуррентного перебора листа рекурсией вверх
    calc_dividers_list_internal(+Number,+List, -DividersList) is det
*/
calc_dividers_list_internal(Number, [H|T], DividersList):-
    (Number mod H =:= 0 ->(
        calc_dividers_list_internal(Number,T,NewDividersList),
        Hidden is Number div H,
        (Hidden \= H -> (
            append(NewDividersList, [H, Hidden], DividersList)
        );(
            append(NewDividersList, [H], DividersList)
        ))
    );(
        calc_dividers_list_internal(Number,T,NewDividersList),
        DividersList = NewDividersList
    )).

/**
    Предикат вычисления суммы Элементов списка
    sum_list(+List,-Sum) is det - стандартная библиотека
*/

/**
    Предикат проверки на то, является ли число избыточным.
    Подразумевается использование в member/3 из стандартной библиотеки
    is_overload_number(+Number) is failure
*/
is_overload_number(Number):-
    calc_dividers_list(Number,DividersList),
    sum_list(DividersList, DividersSum),
    DividersSum - Number > Number.

summable_with_overload_numbers_pair(X,Y,Z):-
    is_overload_number(X),
    is_overload_number(Y),
    X + Y =:= Z.

/**
    Предикат проверки на то, является ли число суммируемым двумя избыточными.
    is_summable_with_overload_numbers(+Number) is failure
*/
is_summable_with_overload_numbers(Number):-
    NewNumber is Number - 1,
    SumNumbers = [1, NewNumber],
    is_summable_with_overload_numbers_internal(SumNumbers,Number, Result),
    print(Number),
    print(Result),
    Result.

/**
    is_summable_with_overload_numbers is failure
*/
is_summable_with_overload_numbers_internal([X,Y], Number, Result):-
    (X =< Y -> (
        (summable_with_overload_numbers_pair(X,Y,Number) -> (
            Result = true
        );(
            NewX is X + 1,
            NewY is Y - 1,
            is_summable_with_overload_numbers_internal([NewX,NewY], Number, Result)
        ))
    ); (
        Result = fail
    )).

not_my(Predicate,Value):- not(call(Predicate,Value)).

/**
    calc_not_summable_with_two_overload_numbers(?Result) is det.

    By mathematical analysis, it can be shown that all integers greater than
    can be written as the sum of two abundant numbers. However, this upper limit cannot be reduced any further
    by analysis even though it is known that the greatest number
    that cannot be expressed as the sum of two abundant numbers is less than this limit.

    Find the sum of all the positive integers which cannot be written as the sum of two abundant numbers.
*/
calc_not_summable_with_two_overload_numbers(Result):-
    numlist(1, 29000, NumberList),
    include(not_my(is_summable_with_overload_numbers), NumberList, ResultList),
    print(ResultList),
    sum_list(ResultList, Result).