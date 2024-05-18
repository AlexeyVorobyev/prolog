max_digits(Number, Max):- 
    number_chars(Number, Chars),
    max_digits_helper(Chars, 0, Max).
    
max_digits_helper([], Max, Max).
max_digits_helper([H|T], MaxSoFar, Max):-
    char_code('0', ZeroCode),
    char_code(H, CharCode),
    Digit is CharCode - ZeroCode,
    NewMax is max(Digit, MaxSoFar),
    max_digits_helper(T, NewMax, Max).

trigger_max_digits(Number):- 
    max_digits(Number, Max), 
    print(Max), nl.