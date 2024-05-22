/**Задание 3.1(2 задача)-------------------------------------------------*/

/**
    Предикат поиска индекса минимального элемента в списке
    find_min_element_index(+List, -MinElementIndex) is det
*/
find_min_element_index(List, MinElementIndex):-
    nth0(0, List, FirstItem),
    find_min_element_index_internal(List,FirstItem, 0,0, MinElementIndex).

/**
    Предикат выхода из рекурсии при пустом списке
    find_min_element_index_internal(+List,?_,?_,+MinIndexSoFar, -MinIndex) is det
*/

find_min_element_index_internal([], _,_, MinIndexSoFar, MinIndex):-
    MinIndex is MinIndexSoFar.

/**
    Предикат выхода из рекурсии при пустом списке
    find_min_element_index_internal(+List, +MinElementSoFar,+CurIndex,+MinIndexSoFar, -MinIndex) is det
*/
find_min_element_index_internal([H|T], MinElementSoFar, CurIndex, MinIndexSoFar, MinIndex):-
    (MinElementSoFar > H -> (
        find_min_element_index_internal(T, H, CurIndex + 1, CurIndex, MinIndex)
    );(
        find_min_element_index_internal(T, MinElementSoFar, CurIndex + 1, MinIndexSoFar, MinIndex)
    )).

/**Задание 3.2(23 задача)-------------------------------------------------*/
/**
    Предикат удаления элемента в списке по индексу
    remove_at(+Index, +List, -Result) is det
*/
remove_at(Index, List, Result) :-
    Index >= 0,
    length(Prefix, Index),
    append(Prefix, [_|Suffix], List),
    append(Prefix, Suffix, Result).


/**
    Предикат поиска двух минимальных элементов
    find_two_min_elements(+List, -MinElementsList) is det
*/
find_two_min_elements(List, MinElementsList):-
    find_min_element_index(List, FirstMinElementIndex),
    remove_at(FirstMinElementIndex, List, ListWithoutFirstMinElement),
    find_min_element_index(ListWithoutFirstMinElement, SecondMinElementIndex),
    nth0(FirstMinElementIndex, List, FirstMinElement),
    nth0(SecondMinElementIndex, ListWithoutFirstMinElement, SecondMinElement),
    MinElementsList = [FirstMinElement,SecondMinElement].

/**Задание 3.3(31 задача)-------------------------------------------------*/

/**
    Предикат посчёта количества чётных элементов в листе
    count_even_elements(+List, ?EvenElementsAmount)
*/
count_even_elements(List,EvenElementsAmount):-
    count_even_elements_internal(List,EvenElementsAmount).

/**
    Предикат выхода из рекурсии
    count_even_elements_internal(+List, ?EvenElementsAmount)
*/
count_even_elements_internal([], EvenElementsAmount):-
    EvenElementsAmount is 0.

/**
    Предикат рекуреентного прохода по листу вверх
    count_even_elements_internal(+List, ?EvenElementsAmount)
*/
count_even_elements_internal([H|T], EvenElementsAmount):-
    (H mod 2 =:= 0 -> (
        count_even_elements_internal(T,NewEvenElementsAmount),
        EvenElementsAmount is 1 + NewEvenElementsAmount
    );(
        count_even_elements_internal(T,NewEvenElementsAmount),
        EvenElementsAmount is NewEvenElementsAmount
    )).