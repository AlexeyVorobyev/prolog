
/**
    Предикат проверки вхождения элемента в список
    in_list(+List,+El) is failure
    Предикат генерации элемента из списка
    in_list(+List,-El) is det
*/
in_list([El|_],El).
in_list([_|T],El):-in_list(T,El).

/**
    Предикат генерации одного размещения с повторением
    arrangement_with_repetitions(+AlphabetList,+Length,-Arrangement) is det
*/
arrangement_with_repetitions(_,0,[]):-!.
arrangement_with_repetitions(AlphabetList,Length,Arrangement):-
    NewLength is Length - 1,
    arrangement_with_repetitions(AlphabetList,NewLength,NewArrangement),
    in_list(AlphabetList, AlphabetItem),
    append(NewArrangement,[AlphabetItem],Arrangement).

/**
    Предикат генерации спсика размещений с повторениями
    arrangement_with_repetitions_list(+AlphabetList,+Length,-ArrangementList) is det
*/
arrangement_with_repetitions_list(AlphabetList,Length,ArrangementList):-
    findall(
        Arrangement,
        arrangement_with_repetitions(AlphabetList,Length,Arrangement),
        ArrangementList
    ).

/**
    Предикат генерации одного размещения без повторений
    arrangement_without_repetitions(+AlphabetList,+Length,-Arrangement) is det
    Length <= AplphabetList length
*/
arrangement_without_repetitions(AlphabetList, Length, Arrangement):-
    length(AlphabetList, AlphabetListLength),
    AlphabetListLength >= Length,
    arrangement_without_repetitions_internal(AlphabetList, Length, Arrangement).

arrangement_without_repetitions_internal(_,0,[]):-!.
arrangement_without_repetitions_internal(AlphabetList,Length,Arrangement):-
    NewLength is Length - 1,
    arrangement_without_repetitions_internal(AlphabetList,NewLength,NewArrangement),
    in_list(AlphabetList, AlphabetItem),
    not(in_list(NewArrangement, AlphabetItem)),
    append(NewArrangement,[AlphabetItem],Arrangement).

/**
    Предикат генерации спсика размещений без повторений
    arrangement_with_repetitions_list(+AlphabetList,+Length,-ArrangementList) is det
*/
arrangement_without_repetitions_list(AlphabetList,Length,ArrangementList):-
    findall(
        Arrangement,
        arrangement_without_repetitions(AlphabetList,Length,Arrangement),
        ArrangementList
    ).

/**
    Предикат генерации одного сочетания с повторениями (Кто это придумал - просто гений)
    comb_with_repetitions(+AlphabetList.+K,-Result).
*/
comb_with_repetitions(_, 0, []):- !.
comb_with_repetitions([Letter|Alphabet], K, [Letter|PrevResult]):-
    KNew is K - 1,
    comb_with_repetitions([Letter|Alphabet], KNew, PrevResult).
comb_with_repetitions([_|Alphabet], K, PrevResult):-
    comb_with_repetitions(Alphabet, K, PrevResult).

/**
    Предикат генерации списка сочетаний с повторениями
    comb_with_repetitions_list(+AlphabetList,+Length,-CombList) is det
*/
comb_with_repetitions_list(AlphabetList,Length,CombList):-
    findall(
        Comb,
        comb_with_repetitions(AlphabetList,Length,Comb),
        CombList
    ).

/**
    Предикат получения хвоста списка после найденного элемента или элемента перед хвостом из списка
    selec(?Item,?List,?Tail) is det
*/
selec(El,[El|T],T).
selec(El,[H|T],[H|S]) :-
      selec(El,T,S).
/**
    Предикат генерации подмножества списка
    subset(+List,-Subset) is det
*/
subset(List, Subset):-
    subset(List, [], Subset).

subset(_List, Subset, Subset).
subset(List, Buf, Subset):-
    selec(Element, List, Tail),
    subset(Tail, [Element|Buf], Subset).

/**
    Предикат получения всех подмножеств спсика
    subset_lsit(+List,-SubsetList) is det
*/
subset_list(List,SubsetList):-
    findall(
        Subset,
        subset(List,Subset),
        SubsetList
    ).


/**
    Слово длины 5, в которых ровно 2 буквы a, остальные буквы не
    повторяются
    comb_6(+RestAlphabetList,?Word) is det
*/
comb_6(RestAlphabetList,Word):-
    comb_with_repetitions([a|RestAlphabetList],5,Word),
    subset(Word,[a,a]),
    \+ subset(Word,[a,a,a]),
    check_repeats(RestAlphabetList,Word,Result),
    Result.

check_repeats([],_,true).
check_repeats([H|T],Word,Result):-
    (not(subset(Word,[H,H])) -> (
        check_repeats(T,Word,NewResult),
        Result = NewResult
    );(
        Result = fail
    )).


/**
    Функция сравнения для includes или filter_list
    is_not_equal(+Triple,+Double,+Xi)
*/
is_not_equal(Triple,Double,Xi):-
    Triple \= Xi,
    Double \= Xi.

/**
    Слова длины 7, в которых ровно 1 буква повторяются 2 раза, ровно
    одна буква повторяется 3 раза остальные буквы не повторяются.
*/
comb_7(AlphabetList,Word):-
    length(AlphabetList, AlphabetListLength),
    AlphabetListLength >= 4,
    comb_with_repetitions(AlphabetList,7,Word),
    in_list(AlphabetList, Triple),
    in_list(AlphabetList, Double),
    Triple \= Double,
    subset(Word,[Triple,Triple,Triple]),
    \+ subset(Word,[Triple,Triple,Triple,Triple]),
    subset(Word,[Double,Double]),
    \+ subset(Word,[Double,Double,Double]),
    include(is_not_equal(Triple,Double),AlphabetList,AlphabetListCleared),
    check_repeats(AlphabetListCleared,Word,Result),
    Result.

