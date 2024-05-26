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

% write_list_str(+String) - напечатать строку
write_list_str([]):-!.
write_list_str([H|List]):-
    write(H),
    write_list_str(List).

% write_list_of_lists(+List) - вывести список списков (список строк)
write_list_of_lists([]):-!.
write_list_of_lists([H|TailListOfLists]):-
    write_list_str(H),
    nl,
    write_list_of_lists(TailListOfLists),
    !.

% write_to_file(+FilePath, +ListOfStrings) - записать в файл список строк
write_to_file(FilePath, ListOfStrings):-
    tell(FilePath),
    write_list_of_lists(ListOfStrings),
    told,
    !.

/**
    './resouces/input/testStrings.txt'
    '/home/lexxv/programming/pet/university/prolog/lab3/resources/input/testStrings.txt'
    './resouces/output/res_<1>.txt'
*/
/**
    Задание 2.1--------------------------------------
    Прочитать из файла строки и вывести длину наибольшей строки.
    max_length_string_in_file(+FilePath,?MaxLength) is det
*/
max_length_string_in_file(FilePath,MaxLength):-
    read_file_strings_in_list(FilePath,ReadListStrings),
    max_length_string(ReadListStrings,MaxLength).

max_length_string([],0).
max_length_string([H|T], MaxLength):-
    max_length_string(T,NewMaxLength),
    length(H, HLength),
    (HLength > NewMaxLength -> (
        MaxLength is HLength
    );(
        MaxLength is NewMaxLength
    )).

/**
    Задание 2.2--------------------------------------
    Дан файл. Определить, сколько в файле строк, не содержащих пробелы.
    no_whitespace_amount_string_in_file(+FilePath,?NoWhiteSpaceAmount) is det
*/
no_whitespace_amount_string_in_file(FilePath,NoWhiteSpaceAmount):-
    read_file_strings_in_list(FilePath,ReadListStrings),
    no_whitespace_amount_string(ReadListStrings,NoWhiteSpaceAmount).

no_whitespace_amount_string([],0).
no_whitespace_amount_string([H|T], NoWhiteSpaceAmount):-
    no_whitespace_amount_string(T,NewNoWhiteSpaceAmount),
    include(not_whitespace,H, WhiteSpacesList),
    length(WhiteSpacesList, WhiteSpacesListLength),
    (WhiteSpacesListLength =:= 0 -> (
        NoWhiteSpaceAmount is NewNoWhiteSpaceAmount + 1
    );(
        NoWhiteSpaceAmount is NewNoWhiteSpaceAmount
    )).

not_whitespace(Xi):-
    Xi == ' '.

/**
    Задание 2.3--------------------------------------
    Дан файл. найти и вывести на экран только те строки, в которых букв А
    больше, чем в среднем на строку.
    more_than_mean_A_strings_in_file(+FilePath,?NoWhiteSpaceAmount) is det

    more_than_mean_A_strings_in_file('/home/lexxv/programming/pet/university/prolog/lab3/resources/input/testStrings.txt',X), write_list_str(X).
*/
more_than_mean_A_strings_in_file(FilePath,ResultStrings):-
    read_file_strings_in_list(FilePath,ReadListStrings),
    count_mean_a_in_list_strings(ReadListStrings,MeanA),
    more_than_mean_A_strings(ReadListStrings,MeanA,ResultStrings).

more_than_mean_A_strings([],_,[]).
more_than_mean_A_strings([H|T],MeanA,Result):-
    more_than_mean_A_strings(T,MeanA,NewResult),
    include(is_A, H, HCountAList),
    length(HCountAList,HCountA),
    (HCountA > MeanA -> (
        append(NewResult,[H], Result)
    );(
        Result = NewResult
    )).


% count_mean_a_in_list_strings(+ListStrings, -Result) - записать в Result среднее количество символов A на строку в файле
count_mean_a_in_list_strings(ListStrings, Result):- count_mean_a_in_list_strings(ListStrings, 0, 0, Result), !.
count_mean_a_in_list_strings([], 0, _, Result):- Result is 0, !.
count_mean_a_in_list_strings([], CountOfStrings, CountOfA, Result):- Result is CountOfA/CountOfStrings, !.
count_mean_a_in_list_strings([String|TailStrings], CountOfStrings, CountOfA, Result):-
    include(is_A, String, ThisCountAList),
    length(ThisCountAList,ThisCountA),
    NewCountA is CountOfA + ThisCountA,
    NewCountOfStrings is CountOfStrings + 1,
    count_mean_a_in_list_strings(TailStrings, NewCountOfStrings, NewCountA, Result), !.

is_A(Xi):-
    Xi == 'A'.

/**
    Задание 2.4--------------------------------------
    Дан файл. Дан файл, вывести самое частое слово.
*/

% count_elements(+List, -L1, -L2) - вывести в L1 уникальные элементы списка List, а в L2 количество повторений каждого элемента
count_elements([], [], []).

count_elements([X|Xs], L1, L2) :-
    count_elements(Xs, L1_Tail, L2_Tail),
    (   member(X, L1_Tail)
    ->  L1 = L1_Tail,
        nth1(Index, L1_Tail, X),
        nth1(Index, L2_Tail, Count),
        NewCount is Count + 1,
        replace(Index, L2_Tail, NewCount, L2)
    ;   L1 = [X|L1_Tail],
        L2 = [1|L2_Tail]
    ).

% replace(+Index, +CurList, +Value, -ResList) - заменить элемент на индексе Index в списке CurList значением Value и вернуть новый список в ResList
replace(1, [_|Xs], Value, [Value|Xs]).
replace(N, [X|Xs], Value, [X|Ys]) :-
    N > 1,
    N1 is N - 1,
    replace(N1, Xs, Value, Ys).

% read_words(+String, -Words) - записать все слова из String в Words
read_words(String, Words) :-
    read_words(String, [], Words).

read_words([], [FirstWord|TailWords], Words) :-
    reverse(FirstWord, FixedFirstWord), % фиксим, что у последнего слова обратный порядок букв
    reverse([FixedFirstWord|TailWords], Words), % фиксим, что слова стоят в обратном порядке
    !.
read_words([C|Cs], Acc, Words) :-
    (is_word_char(C) ->
        read_word(Cs, [C], RestCs, Word),
        Acc1 = [Word|Acc],
        read_words(RestCs, Acc1, Words)
    ;
        read_words(Cs, Acc, Words)
    ).

% read_word(+Chars, +Acc, -RestCs, -Word) - идти по символам и записывать слово,
%в Word записать получившееся слово, в RestCs вернуть оставшиеся символы, которые уже не являются частью слова
read_word([], Word, [], Word) :- !.
read_word([C|Cs], Acc, RestCs, Word) :-
    (is_word_char(C) -> (
        read_word(Cs, [C|Acc], RestCs, Word)
    );(
        reverse(Acc, Word),
        RestCs = [C|Cs]
    )).

% is_word_char(+C) - проверка, является ли C буквой
is_word_char(C) :-
    code_type(C, alpha).

% get_max_count_element(+Elements, +Counts, -Result) - получить в Result элемент с наибольшим количеством повторов
get_max_count_element(Elements, Counts, Result):-
    max_list(Counts, MaxCount),
    nth1(IndexMaxCount, Counts, MaxCount),
    nth1(IndexMaxCount, Elements, MaxCountWord),
    Result = MaxCountWord.

% read_all_words(Strings, Words) - считать все слова в списке строк
read_all_words(Strings, Words):- read_all_words(Strings, [], Words), !.
read_all_words([], Words, Words):- !.
read_all_words([String|StringsTail], CurWords, Words):-
    read_words(String, StringWords),
    append(CurWords, StringWords, NewCurWords),
    read_all_words(StringsTail, NewCurWords, Words), !.

% most_offen_word_in_file(+FilePath) - найти наиболее часто повторяющееся слово в файле
most_often_word_in_file(FilePath):- most_often_word_in_file(FilePath, Result), write("Result: "), write_list_str(Result), !.
most_often_word_in_file(FilePath, Result):-
    read_file_strings_in_list(FilePath, StringList),
    read_all_words(StringList, Words),
    count_elements(Words, UniqueWords, CountWords),
    get_max_count_element(UniqueWords, CountWords, Result), !.

/**
    Задание 2.5--------------------------------------
    Дан файл, вывести в отдельный файл строки, состоящие из слов, не
    повторяющихся в исходном файле.
*/

% get_unique_words(+Elements, +Counts, -UniqueWords) - получить список всех неповторяющихся слов
get_unique_words(Elements, Counts, UniqueWords):- get_unique_words(Elements, Counts, [], UniqueWords), !.
get_unique_words([], _, UniqueWords, UniqueWords):- !.
get_unique_words([Element|TailElements], [CountElement|TailCounts], CurUniqueWords, UniqueWords):-
    CountElement is 1,
    get_unique_words(TailElements, TailCounts, [Element|CurUniqueWords], UniqueWords), !.
get_unique_words([_|TailElements], [_|TailCounts], CurUniqueWords, UniqueWords):-
    get_unique_words(TailElements, TailCounts, CurUniqueWords, UniqueWords), !.

% print_string_unique_words(+String, +UniqueWords) - напечатать строку из уникальных слов
print_string_unique_words(String, UniqueWords):-
    read_words(String, WordsInString),
    print_words_if_unique(WordsInString, UniqueWords), !.

% print_words_if_unique(+Words, +UniqueWords) - напечатать все уникальные слова
print_words_if_unique([], _):- !.
print_words_if_unique([Word|TailWords], UniqueWords):-
    member(Word, UniqueWords),
    write_list_str(Word),
    write(" "),
    print_words_if_unique(TailWords, UniqueWords), !.
print_words_if_unique([_|TailWords], UniqueWords):-
    print_words_if_unique(TailWords, UniqueWords), !.

% print_strings_unique_words(+Strings, +UniqueWords) - напечатать все строки, состоящие только из уникальных слов
print_strings_unique_words([], _):- !.
print_strings_unique_words([String|TailStrings], UniqueWords):-
    print_string_unique_words(String, UniqueWords),
    nl,
    print_strings_unique_words(TailStrings, UniqueWords), !.

% print_strings_with_only_unique_words(+FilePath, +OutputFile) - записать в файл OutputFile строки с только уникальными словами из файла FilePath
print_strings_with_only_unique_words(FilePath, OutputFile):-
    read_file_strings_in_list(FilePath, StringList),
    read_all_words(StringList, Words),
    count_elements(Words, SetWords, CountWords),
    get_unique_words(SetWords, CountWords, UniqueWords),
    tell(OutputFile),
    print_strings_unique_words(StringList, UniqueWords),
    told, !.