-module(map_refs).
-export([start/0, init/0, loop/1]).

start() ->
  Pid = spawn(?MODULE, init, []),
  Pid.

init() ->
  loop(dict:new()).

loop(D) ->
  receive
    {Pid, {add, Key, Value}} ->
      NextDict = dict:store(Key, Value, D),
      Pid ! ok,
      loop(NextDict);
    {Pid, {read, Key}} ->
      case dict:fetch(Key, D) of
        error      -> Pid ! {error, not_found};
        {ok, Data} -> Pid ! {ok, Data}
      end
  end.
