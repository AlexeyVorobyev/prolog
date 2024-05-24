/**
filter_list(_,+InitialList, ?FilteredList) is det
*/
filter_list(_, [], []).

/**
filter_list(:Predicate,+InitialList, -FilteredList) is det
*/
filter_list(Predicate,[X|Xt],[X|Yt]):-
    call(Predicate,X),
    filter_list(Predicate, Xt, Yt).

/**
filter_list(:Predicate,+InitialList, -FilteredList) is det
*/
filter_list(Predicate, [_|Xt], FilteredList) :-
    filter_list(Predicate, Xt, FilteredList).




/**ЗАДАНИЕ 7.1(38)-----------------------------------------------*/

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
list_intersection_internal([],SecondList,[]).

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
    filter_list(is_equal(H),SecondList,IncludedList),
    length(IncludedList,IncludedListLength),
    (IncludedListLength >= 1 -> (
        list_intersection_internal(T,SecondList,NewResultList),
        append(NewResultList, [H], ResultList)
    );(
        list_intersection_internal(T,SecondList,NewResultList),
        ResultList = NewResultList
    )).

/**
Дан целочисленный массив и отрезок a..b. Необходимо найти количество
элементов, значение которых принадлежит этому отрезку.
check_amount_items_in_range(+List,+A,+B,?Amount) is det.
*/
check_amount_items_in_range(List,A,B,Amount):-
    numlist(A, B, BetweenList),
    lists_intersection(List, BetweenList, ResultList),
    length(ResultList, Amount).

/**ЗАДАНИЕ 7.2(43)-----------------------------------------------*/
/**
Дан целочисленный массив. Необходимо найти количество минимальных
элементов.
find_min_element_amount(+List,?Amount) is det.
*/
find_min_element_amount(List,Amount):-
    min_list(List, Min),
    filter_list(is_equal(Min), List, MinList),
    length(MinList, Amount).

/**ЗАДАНИЕ 7.3(53)-----------------------------------------------*/

/**
    specific_criteria(+Mean,+Max,+Item) is failure
*/
specific_criteria(Mean,Max,Item):-
    Item > Mean,
    Item < Max.

/**
Для введенного списка построить новый с элементами, большими, чем среднее
арифметическое списка, но меньшими, чем его максимальное значение.
filter_by_specific_criteria(+List,?ResultList) is det
*/
filter_by_specific_criteria(List,ResultList):-
    max_list(List, Max),
    sum_list(List, Sum),
    length(List,ListLength),
    Mean is Sum / ListLength,
    filter_list(specific_criteria(Mean,Max), List, ResultList).

/**ЗАДАНИЕ 7.4(56)-----------------------------------------------*/

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
is_primary(+Value) is failure
*/
is_primary(1).
is_primary(Value):-
    calc_dividers_list(Value,DividersList),
    length(DividersList, Length),
    Length =:= 2.

/**
not_criteria(:Predicate,+Value) is failure
*/
not_criteria(Predicate,Value):- not(call(Predicate,Value)).

/**
непростых элементов,
которые больше, чем среднее арифметическое простых.
*/
specific_criteria2(Mean,Value):-
    Value > Mean,
    not_criteria(is_primary, Value).

/**
Для введенного списка посчитать среднее арифметическое непростых элементов,
которые больше, чем среднее арифметическое простых.
calc_specific_mean(+List,?Result) is det
*/
calc_specific_mean(List,Result):-
    filter_list(is_primary, List, PrimariesList),
    sum_list(PrimariesList, SumPrimariesList),
    length(PrimariesList, LenPrimariesList),
    MeanPrimariesList is SumPrimariesList / LenPrimariesList,
    filter_list(specific_criteria2(MeanPrimariesList), List, NonPriamriesList),
    sum_list(NonPriamriesList, SumNonPriamriesList),
    length(NonPriamriesList, LenNonPriamriesList),
    Result is SumNonPriamriesList / LenNonPriamriesList.





