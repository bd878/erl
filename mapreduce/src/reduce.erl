-module(reduce).
-export([task/2]).

task(Acc0, ReduceFun) ->
  receive
    {reduce, {K, V}} ->
      Acc = case get(K) of
          undefined -> Acc0;
          CurrentAcc -> CurrentAcc
        end,
      put(K, ReduceFun(V, Acc)),
      task(Acc0, ReduceFun);
    {collect, Pid} ->
      Pid ! {result, get()},
      task(Acc0, ReduceFun)
  end.


