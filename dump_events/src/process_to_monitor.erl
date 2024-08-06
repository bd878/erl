-module(process_to_monitor).
-export([start/0, init/0, loop/1, bind_monitor/2]).

start() ->
  Pid=spawn(?MODULE, init, []),
  Pid.

init() ->
  loop(10000).

loop(Timeout) ->
  receive
    {Pid, {restart, NewTimeout}} ->
      Pid ! ok,
      loop(NewTimeout)
  after
    Timeout ->
      exit(timeout)
  end.
      
bind_monitor(Server, Pid) ->
  Ref = erlang:monitor(process, Pid),
  receive
    {'DOWN', Ref, process, _Pid, Reason} ->
      io:format("Exit reason: ~p~n", [Reason]),
      Server ! Reason;
    {Ref, ok} ->
      erlang:demonitor(Ref, [flush]),
      Server ! {ok, Ref}
  end.
  
