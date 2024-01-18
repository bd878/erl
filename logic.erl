-module(logic).
-export([is_not/1]).

is_not(A) ->
  case A of
    true -> false;
    false -> true
  end.
