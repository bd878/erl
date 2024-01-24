-module(evens).
-export([evens/1]).

evens([]) -> [];
evens([X|Xs]) ->
  case X rem 2 == 0 of
    true ->
      [X| evens(Xs)];
    _ ->
      evens(Xs)
  end.
