-module(test).
-export([test_map_reduce/0]).

test_map_reduce() ->
  MapFunc = fun(Line) -> lists:map(fun(Word) -> {Word, 1} end, Line) end,
  ReduceFunc = fun(V, Acc) -> Acc + V end,
  mapreduce:map_reduce(3, 5, MapFunc, ReduceFunc, 0,
    [[this, is, a, boy],
     [this, is, a, girl],
     [this, is, a, lovely, boy]]).


