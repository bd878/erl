#!/usr/bin/env escript

%% -*- erlang -*-
%%! -sname factorial -mnesia debug verbose

reverse([]) -> [];
reverse([H|T]) -> reverse(T)++[H].

tail_reverse(L) -> tail_reverse(L, []).

tail_reverse([], Acc) -> Acc;
tail_reverse([H|T], Acc) -> tail_reverse(T, [H|Acc]).

main(_) ->
  io:format("reverse: ~p~n", [reverse([1, 2, 3, 4])]),
  io:format("tail_reverse: ~p~n", [tail_reverse([1, 2, 3, 4])]).
