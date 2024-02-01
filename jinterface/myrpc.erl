-module(myrpc).
-export([setup/0, server/0, facLoop/0,
  f/1]).

setup() ->
  spawn('bar@STC',myrpc,server,[]).

server() ->
  register(facserver,self()),
  facLoop().

facLoop() ->
  receive
    {Pid,N} ->
      Pid ! {ok,fac(N)}
  end,
  facLoop().

f(N) ->
  {facserver, 'bar@STC'} ! {self(), N},
    receive
      {ok, Res} ->
        io:format("Factorial of ~p is ~p.~n", [N,Res])
    end.
