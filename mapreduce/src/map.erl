-module(map).
-export([task/2]).

task(Reduce_processes, MapFun) ->
  receive
    {map, Data} ->
      Result = MapFun(Data),
      io:format("Map function produce: ~w~n", [Result]),
      lists:foreach(
        fun({K, V}) ->
          Reducer_proc = mapreduce:find_reducer(Reduce_processes, K),
          Reducer_proc ! {reduce, {K, V}}
        end,
        Result
      ),
      task(Reduce_processes, MapFun)
  end.


