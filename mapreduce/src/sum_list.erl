-module(sum_list).
-export([sum/2]).

sum(Fn, List) ->
  acc(0, List, Fn).
  
acc(Acc, [H|L], Fn) ->
  NextAcc = Fn(Acc, H),
  acc(NextAcc, L, Fn);

acc(Acc, [], _Fn) -> Acc.
