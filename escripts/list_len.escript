#!/usr/bin/env escript

%% -*- erlang -*-
%%! -sname list_len -mnesia debug verbose

len([_|T]) -> 1 + len(T);
len([]) -> 0.

tail_len(L) -> tail_len(L, 0).

tail_len([], Acc) -> Acc;
tail_len([_|T], Acc) -> tail_len(T, Acc+1).

duplicate(0, _) -> [];
duplicate(N, Term) when N > 0 ->
  [Term|duplicate(N-1,Term)].

main(_) ->
  io:format("~p~n", [tail_len([1,2,3,4,5])]),
  io:format("~p~n", [duplicate(5, a)]).
