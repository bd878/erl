#!/usr/bin/env escript
%% -*- erlang -*-
%%! -pa ./src

main(_) ->
  io:format("works~n"),
  DoubleFn = fun(A) when is_integer(A) -> A*2 end,
  Res = funcs:map(DoubleFn, [1,2,3,4,5]),
  io:format("~p~n", [Res]).
