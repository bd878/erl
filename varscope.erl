-module(varscope).
-export([safe/1]).
-export([preferred/1]).

safe(X) ->
  case X of
    one -> Y = 12;
        -> Y = 196;
  end,
  X+Y.

preferred(X) ->
  Y = case X of
        one -> 12;
        _   -> 196
      end,
  X+Y.
