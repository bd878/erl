-module(mapreduce).
-export([repeat_exec/2, find_reducer/2, map_reduce/6]).

%% Execute the function N times,
%% and put the result into a list
repeat_exec(N, Func) ->
  lists:map(Func, lists:seq(0, N-1)).

find_reducer(Processes, Key) ->
  Index = erlang:phash2(Key, length(Processes)),
  lists:nth(Index, Processes).

%%% identify the mapper process by random
find_mapper(Processes) ->
  case rand:uniform(length(Processes)) of
    0 -> find_mapper(Processes);
    N -> lists:nth(N, Processes)
  end.

%%% collect result synchronously from
%%% a reducer process
collect(ReduceProc) ->
  ReduceProc ! {collect, self()},
  receive
    {result, Result} ->
      Result
  end.

%% The entry point of the map/reduce framework
map_reduce(NMap, NReduce, MapFunc, ReduceFunc, Acc0, List) ->
  %% start the reducer processes
  Reducers = repeat_exec(
    NReduce, fun(_) -> spawn(reduce, task, [Acc0, ReduceFunc]) end
  ),

  io:format("Reduce processes ~w are started~n", [Reducers]),

  Mappers = repeat_exec(
    NMap, fun(_) -> spawn(map, task, [Reducers, MapFunc]) end
  ),

  io:format("Map processes ~w are started~n", [Mappers]),

  %% send data to the mapper processes
  ExtractFunc =
    fun(N) ->
      ExtractedLine = lists:nth(N+1, List),
      MapProc = find_mapper(Mappers),
      io:format("Send ~w to map process ~w~n", [ExtractedLine, MapProc]),
      MapProc ! {map, ExtractedLine}
    end,

  repeat_exec(length(List), ExtractFunc),

  timer:sleep(2000),

  io:format("Collect all data from reduce processes~n"),

  AllResults =
    repeat_exec(length(Reducers),
      fun(N) ->
        collect(lists:nth(N+1, Reducers))
      end),
  lists:flatten(AllResults).

%% Execute the function N times,
%% and put the result into a list
