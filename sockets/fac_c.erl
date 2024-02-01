-module(fac_c).
-export([call/1]).

call(X) ->
  {any, 'c1@STC2'} ! {self(), X},
  receive
    {ok, Result} ->
      Result
  end.
