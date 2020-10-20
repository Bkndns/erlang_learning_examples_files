-module(reverse_and_tailrec).
-export([tail_reverse/1, tail_reverse/2, tduplicate/2, tduplicate/3, duplicate/2, fact/1, t_lener/1, t_lener/2, tail_fac/1, tail_fac/2]).

fact(0) -> 1;
fact(N) when N > 0 -> N * fact(N-1).

t_lener(L) -> t_lener(L, 0).
t_lener([], Acm) -> Acm;
t_lener([_|T], Acm) -> t_lener(T, Acm + 1).

tail_fac(N) -> tail_fac(N, 1).
tail_fac(0, Acc) -> Acc;
tail_fac(N, Acc) when N > 0 -> tail_fac(N - 1, N * Acc).

duplicate(0, _) -> [];
duplicate(N, Term) when N > 0 -> 
    [Term | duplicate(N - 1, Term)].

tduplicate(N, Term) -> tduplicate(N, Term, []).
tduplicate(0, _, List) -> List;
tduplicate(N, Term, List) when N > 0 -> 
    tduplicate(N - 1, Term, [Term | List]).

tail_reverse(L) -> tail_reverse(L, []).
tail_reverse([], Acc) -> Acc;
tail_reverse([H|T], Acc)-> tail_reverse(T, [H | Acc]).