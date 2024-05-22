/**Задание 2.1----------------------------------------*/

/**
Входной предикат подсчёта макс цифры
max_digit(+Number, ?Max) is det
*/
max_digit(Number, Max):-
    number_chars(Number, Chars),
    max_digit_helper(Chars, 0, Max).

/**
Условие выхода из Рекурсии
max_digit_helper(+[], +MaxSoFar, ?Max) is det
*/
max_digit_helper([], MaxSoFar, Max):-
    Max is MaxSoFar.
/**
Вспомогательный предикат для рекуррентного обхода списка символов
max_digit_helper(+[H|T], +MaxSoFar, ?Max) is det
*/
max_digit_helper([H|T], MaxSoFar, Max):-
    char_code('0', ZeroCode),
    char_code(H, CharCode),
	/**Получение числового*/
    Digit is CharCode - ZeroCode,
	/**Назначение нового максимума*/
    NewMax is max(Digit, MaxSoFar),
    max_digit_helper(T, NewMax, Max).

/**Задание 2.2-----------------------------------------------*/

/**
Входной предикат подсчёта суммы цифр делящихся на 3
sum_of_digits_divided_by_3(+Number,-Sum) is det
*/
sum_of_digits_divided_by_3(Number, Sum):-
    number_chars(Number, Chars),
    sum_of_digits_divided_by_3_helper(Chars, 0, Sum).

/**
Условие выхода из цикла + унификация 3 аргумента
sum_of_digits_divided_by_3_helper(+List, +SumAcc, -Sum) is det
*/
sum_of_digits_divided_by_3_helper([], SumAcc, Sum):-
    Sum is SumAcc.
/**
Вспомогательный предикат для рекуррентного обхода списка символов
sum_of_digits_divided_by_3_helper(+List, +SumSoFar, -Sum) is det
*/
sum_of_digits_divided_by_3_helper([H|T], SumAcc,Sum):-
    char_code('0', ZeroCode),
    char_code(H, CharCode),
	/**Получение числового значения*/
    Digit is CharCode - ZeroCode,
	/**Изменение суммы по условию, ветвление*/
	(Digit mod 3 =:= 0 -> (
	    NewSum is Digit + SumAcc,
        sum_of_digits_divided_by_3_helper(T, NewSum, Sum)
	);(
	    sum_of_digits_divided_by_3_helper(T, SumAcc, Sum)
	)).

/**Задание 2.3-----------------------------------------------*/

/**
    Предикат подсчёта количества делителей числа
    calc_dividers_amount(+Number, -Amount) is det
*/
calc_dividers_amount(Number, Amount):-
    numlist(1, Number, List),
    calc_dividers_amount_internal(Number, List, 0, Amount).

/**
    Предикат выхода из рекурсии и унификации Amount
    calc_dividers_amount_internal(+Number, +List, +AmountAcc, -Amount) is det
*/
calc_dividers_amount_internal(Number, [], AmountAcc, Amount):-
    Amount is AmountAcc.

/**
    Предикат рекуррентного перебора листа рекурсией вниз
    calc_dividers_amount_internal(+Number,+List, +AmountAcc, -Amount) is det
*/
calc_dividers_amount_internal(Number, [H|T], AmountAcc, Amount):-
    (Number mod H =:= 0 ->(
        NewAmountAcc is AmountAcc + 1,
        calc_dividers_amount_internal(Number,T,NewAmountAcc, Amount)
    );(
        calc_dividers_amount_internal(Number,T,AmountAcc, Amount)
    )).

/**
    Предикат подсчёта количества делителей числа
    calc_dividers_amount_up(+Number, -Amount) is det
*/
calc_dividers_amount_up(Number, Amount):-
    numlist(1, Number, List),
    calc_dividers_amount_internal_up(Number, List, Amount).

/**
    Предикат выхода из рекурсии и унификации Amount
    calc_dividers_amount_internal_up(+Number, +List, -Amount) is det
*/
calc_dividers_amount_internal_up(Number, [], Amount):-
    Amount is 0.

/**
    Предикат рекуррентного перебора листа рекурсией вниз
    calc_dividers_amount_internal_up(+Number,+List, -Amount) is det
*/
calc_dividers_amount_internal_up(Number, [H|T], Amount):-
    (Number mod H =:= 0 ->(
        calc_dividers_amount_internal_up(Number,T, NewAmount),
        Amount is 1 + NewAmount
    );(
        calc_dividers_amount_internal_up(Number,T, NewAmount),
        Amount is NewAmount
    )).