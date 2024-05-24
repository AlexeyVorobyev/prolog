%in_list(?List, ?El) - если El унифицирована, то проверить, входит ли данный элемент в массив
% если El не унифицирован, будут возвращать все элементы по очереди, до точки.
% если List не унифицирован, будет возвращён список с El.
in_list([El|_], El).
in_list([_|T], El):-in_list(T, El).

% Решение логической задачки.
%Пятеро детей Алик, Боря, Витя, Лена и Даша приехали в лагерь из 5
%разных городов: Харькова, Умани, Полтавы, Славянска и Краматорска. Есть 4
%высказывания:
%1) Если Алик не из Умани, то Боря из Краматорска.
%2) Или Боря, или Витя приехали из Харькова.
%3) Если Витя не из Славянска, то Лена приехала из Харькова.
%4) Или Даша приехала из Умани, или Лена из Краматорска.
%Кто откуда приехал?
% pr_kids/0

pr_kids:-
    Kids = [_, _, _, _, _],

    in_list(Kids, [alek, _]),
    in_list(Kids, [borya, _]),
    in_list(Kids, [vitya, _]),
    in_list(Kids, [lena, _]),
    in_list(Kids, [dasha, _]),

    in_list(Kids, [_, kharkiv]),
    in_list(Kids, [_, uman]),
    in_list(Kids, [_, poltava]),
    in_list(Kids, [_, slavansk]),
    in_list(Kids, [_, kramatorsk]),

    %1) Если Алик не из Умани, то Боря из Краматорска.
    in_list(Kids, [alek, NotUman]),
    (NotUman \= uman -> (
        in_list(Kids, [borya, kramatorsk])
    ); true),

    %2) Или Боря, или Витя приехали из Харькова.
    in_list(Kids, [borya, ProbablyKharkiv1]),
    in_list(Kids, [vitya, ProbablyKharkiv2]),
    (ProbablyKharkiv1 == kharkiv; ProbablyKharkiv2 == kharkiv),

    %3) Если Витя не из Славянска, то Лена приехала из Харькова.
    in_list(Kids, [vitya, NotSlavansk]),
    (NotSlavansk \= slavansk -> (
        in_list(Kids, [lena, kharkiv])
    ); true),
%
    %4) Или Даша приехала из Умани, или Лена из Краматорска.
    in_list(Kids, [dasha, ProbablyUman]),
    in_list(Kids, [lena, ProbablyKramatorsk]),
    (ProbablyUman == uman; ProbablyKramatorsk == kramatorsk),

    /**Получение результата*/
    in_list(Kids, [alek, AlekRodina]),
    in_list(Kids, [borya, BoryaRodina]),
    in_list(Kids, [vitya, VityaRodina]),
    in_list(Kids, [lena, LenaRodina]),
    in_list(Kids, [dasha, DashaRodina]),

    write("alex rodina:"),write(AlekRodina),write(" "), nl,
    write("borya rodina:"),write(BoryaRodina),write(" "), nl,
    write("vitya rodina:"),write(VityaRodina),write(" "), nl,
    write("lena rodina:"),write(LenaRodina),write(" "), nl,
    write("dasha rodina:"),write(DashaRodina),write(" "), nl.

%alex rodina:uman
%borya rodina:kharkiv
%vitya rodina:slavansk
%lena rodina:kramatorsk
%dasha rodina:poltava