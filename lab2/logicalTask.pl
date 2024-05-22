%in_list(?List, ?El) - если El унифицирована, то проверить, входит ли данный элемент в массив
% если El не унифицирован, будут возвращать все элементы по очереди, до точки.
% если List не унифицирован, будет возвращён список с El.
in_list([El|_], El).
in_list([_|T], El):-in_list(T, El).

% Решение логической задачки.
%Три подруги вышли в белом, зеленом и синем платьях и туфлях.
%Известно, что только у Ани цвета платья и туфлей совпадали. Ни туфли, ни платье Вали не
%были белыми. Наташа была в зеленых туфлях. Определить цвета платья и туфель на каждой
%из подруг
% pr_girls/0
pr_girls:-
    Girls = [_, _, _],

    in_list(Girls, [ann, _, _]),
    in_list(Girls, [valya, _, _]),
    in_list(Girls, [natasha, _, _]),

    in_list(Girls, [_, white, _]),
    in_list(Girls, [_, green, _]),
    in_list(Girls, [_, blue, _]),

    in_list(Girls, [_, _,white]),
    in_list(Girls, [_, _,green]),
    in_list(Girls, [_, _,blue]),

    in_list(Girls, [ann, SameColor1, _]),
    in_list(Girls, [ann, _, SameColor2]),
    SameColor1 = SameColor2,

    not(in_list(Girls, [valya, white, _])),
    not(in_list(Girls, [valya, _, white])),

    in_list(Girls,[natasha, _, green]),

    in_list(Girls, [ann, DressAnn, ShoesAnn]),
    in_list(Girls, [valya, DressValya, ShoesValya]),
    in_list(Girls, [natasha, DressNatasha, ShoesNatasha]),
    write("ann dress:"),write(DressAnn),write(" "), nl,
    write("valya dress:"),write(DressValya),write(" "),nl,
    write("natasha dress:"),write(DressNatasha), write(" "),nl,
    write("ann shoes:"),write(ShoesAnn),write(" "), nl,
    write("valya shoes:"),write(ShoesValya),write(" "),nl,
    write("natasha shoes:"),write(ShoesNatasha), write(" "),nl,!.