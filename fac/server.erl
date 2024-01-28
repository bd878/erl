-module(server).
-export([server/0,facLoop/0]).

server() ->
  register(facserver,self()),
  facLoop().

facLoop() ->
  receive
    {Pid,N} ->
      Pid ! {ok, fac(N)}
  end,
  facLoop().
