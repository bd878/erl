-module(call).
-export([loop/2]).

loop(Server, Timeout) ->
  receive
    Server ->
      Server ! ok
  after Timeout -> %% event fires
    Server ! done
  end.
