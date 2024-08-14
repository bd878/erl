#!/usr/bin/env escript

%% -*- erlang -*-
%%! -sname quicksort -mnesia debug verbose

quicksort([]) -> [];
quicksort([Pivot|Rest]) ->
  {Smaller, Larger} = partition(Pivot, Rest, [], []),
  quicksort(Smaller) ++ [Pivot] ++ quicksort(Larger).

partition(_, [], Smaller, Larger) -> {Smaller, Larger}.
partition(Pivot, [H|T], Smaller, Larger) ->
  if H <= Pivot -> partition(Pivot, T, [H|Smaller], Larger);
     H > Pivot -> partition(Pivot, T, Smaller, [H|Larger])
  end.

