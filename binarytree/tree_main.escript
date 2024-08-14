#!/usr/bin/env escript

%% -*- erlang -*-
%%! -sname tree_main -mnesia debug verbose

main(_) ->
  T1 = tree:insert(a, 1, tree:empty()),
  io:format("~p~n", [tree:lookup(a, T1)]).
