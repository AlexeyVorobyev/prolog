/**
    Универсальные предикаты для чтения и записи в файл списка строк
*/

% read_str_one(+CurrentChar, +CurrentStr, -ResultStr, -Flag) - прочитать 1 строку, записать в ResultStr, и вернуть флаг, 1 - переход на новую строку , 0 - конец файла
read_str_one(-1,CurrentStr,CurrentStr,0):-!.
read_str_one(10,CurrentStr,CurrentStr,1):-!.
read_str_one(26,CurrentStr,CurrentStr,0):-!.
read_str_one(CurrentSymbol, CurrentStr, ResultStr, Flag):-
    char_code(ResSymbol, CurrentSymbol),
    append(CurrentStr,[ResSymbol],NewCurrentStr),
    get0(NewSymbol),
    read_str_one(NewSymbol,NewCurrentStr,ResultStr,Flag).

% read_all_str(-ResultList) - считать все строки до конца строки или файла.
read_all_str(ResultList):- read_all_str(ResultList, [], 1), !.

% read_all_str(-ResultList, +CurrentList, +Flag)
read_all_str(CurrentList, CurrentList, 0):-!.
read_all_str(StrList, CurrentList, _):-
    get0(NewSymbol),
    read_str_one(NewSymbol,[],ResultStr,Flag),
    append(CurrentList,[ResultStr],NewStrList),
    read_all_str(StrList,NewStrList,Flag).

% read_file_strings_in_list(+FilePath, -ListOfStrings) - считать все строки из файла в виде списка строк
read_file_strings_in_list(FilePath, ListOfStrings):-
    see(FilePath),
    read_all_str(ListOfStrings),
    seen.

not_whitespace(Xi):-Xi \= ' '.

filter_whitespaces([],[]).
filter_whitespaces([H|T],ResultList):-
    filter_whitespaces(T,NewResultList),
    include(not_whitespace, H, FilteredData),
    append(NewResultList, [FilteredData], ResultList).

read_graph(FilePath,GraphList):-
    read_file_strings_in_list(FilePath,RawList),
    filter_whitespaces(RawList,GraphList).


/**
    Предикат проверки вхождения элемента в список
    in_list(+List,+El) is failure
    Предикат генерации элемента из списка
    in_list(+List,-El) is det
*/
in_list([El|_],El).
in_list([_|T],El):-in_list(T,El).

%--------------------------------------------------------------------------------

/**
    Функция преобразования матрицы(Списка) смежности в список вершин
    vertexes(+Matrix,-VertexList_ is det
*/
vertexes([],[]).
vertexes([[From,To]|T],VertexList):-
    vertexes(T,NewVertexList),
    (not(in_list(NewVertexList,From)),not(in_list(NewVertexList,To))->(
        append(NewVertexList, [From,To], VertexList)
    );(
        (not(in_list(NewVertexList,To))->(
            append(NewVertexList, [To], VertexList)
        );(
            not(in_list(NewVertexList,From))->(
                append(NewVertexList, [From], VertexList)
            );(
                VertexList = NewVertexList
            )
        ))
    )).


is_in_edge(Vertex,[E1,E2]):-
    Vertex == E1;
    Vertex == E2.

/**
    Функция получения связей для каждой вершины в виде списка цифр
    calculate_adjacency(+GraphMatrix,+GraphVertexes,-ResultList) is det
*/
calculate_adjacency(_,[],[]).
calculate_adjacency(GraphMatrix,[H|T],ResultList):-
    calculate_adjacency(GraphMatrix,T,NewResultList),
    include(is_in_edge(H), GraphMatrix, Adjacents),
    length(Adjacents, AdjacentsLength),
    append(NewResultList, [AdjacentsLength], ResultList).


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
    Проверка автоморфости
    check_automorph

    1. Проврека на одинаковую длину списка смежности;
    2. Проверка на одинаковую длину вершин;
    3. Проверка на одинаковую длину количества связей на вершину по графам (лишнее);
    4. Пересечение списков из п.3 и сравнение длин с 1 списком из п 3.
*/
check_automorph:-
    read_graph(
        '/home/lexxv/programming/pet/university/prolog/lab3/graphs/resources/graph1.txt',
        FirstGraphMatrix
    ),
    read_graph(
        '/home/lexxv/programming/pet/university/prolog/lab3/graphs/resources/graph2.txt',
        SecondGraphMatrix
    ),
    length(FirstGraphMatrix, FirstGraphMatrixLength),
    length(SecondGraphMatrix, SecondGraphMatrixLength),
    FirstGraphMatrixLength == SecondGraphMatrixLength,
    vertexes(FirstGraphMatrix, FirstGraphVertex),
    vertexes(SecondGraphMatrix, SecondGraphVertex),
    length(FirstGraphVertex, FirstGraphVertexLength),
    length(SecondGraphVertex, SecondGraphVertexLength),
    FirstGraphVertexLength == SecondGraphVertexLength,
    calculate_adjacency(FirstGraphMatrix,FirstGraphVertex, FirstGraphAdjacents),
    calculate_adjacency(SecondGraphMatrix,SecondGraphVertex, SecondGraphAdjacents),
    length(FirstGraphAdjacents, FirstGraphAdjacentsLength),
    length(SecondGraphAdjacents, SecondGraphAdjacentsLength),
    FirstGraphAdjacentsLength == SecondGraphAdjacentsLength.
    lists_intersection(FirstGraphAdjacents, SecondGraphAdjacents, ResultAdjacents),
    length(ResultAdjacents, ResultAdjacentsLength),
    ResultAdjacentsLength == FirstGraphAdjacentsLength.




