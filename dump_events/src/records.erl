-module(records).
-export([start/0, init/0, loop/1]).

-record(state, {events}).
-record(event, {name,
                pid,
                description}).

start() ->
  Pid=spawn(?MODULE, init, []),
  Pid.

init() ->
  loop(#state{events=orddict:new()}).

loop(S = #state{}) ->
  receive
    {Pid, Name, Description} ->
      NewEvents = orddict:store(Name, #event{
        name=Name,
        pid=Pid,
        description=Description
      }, S#state.events),
      Pid ! ok,
      loop(S#state{events=NewEvents});
    dump ->
      orddict:map(fun(_Name, Event) -> io:format("~p~n", [Event]) end, S#state.events),
      loop(S);
    Unknown ->
      io:format("Unknown message: ~p~n", [Unknown]),
      loop(S)
  end.
  
