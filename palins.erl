-module(palins).
-export([palins/1]).

palins([]) -> [];
palins([X|Xs]) ->
  case palin(X) of
    true ->
      [X| palins(Xs)];
    _ ->
      palins(Xs)
  end.
palin(X) -> X == reverse(X).
