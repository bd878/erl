-module(listlen).
-export([listlen/1]).
-export([listlen_case/1]).

listlen([]) -> 0;
listlen([_|Xs]) -> 1 + listlen(Xs).

listlen_case(Y) ->
  case Y of
    [] -> 0;
    [_|Xs] -> 1 + listlen(Xs)
  end.
