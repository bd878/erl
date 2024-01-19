-module(tailcall).
-export([merge/2, average/1]).

merge(Xs, Ys) ->
  lists:reverse(mergeL(Xs,Ys,[])).

mergeL([X|Xs],Ys,Zs) ->
  mergeR(Xs,Ys,[X|Zs]);
mergeL([],[],Zs) ->
  Zs.

mergeR(Xs,[Y|Ys],Zs) ->
  mergeL(Xs,Ys,[Y|Zs]);
mergeR([],[],Zs) ->
  Zs.

average(List) -> average_acc(List, 0, 0).
average_acc([], Sum, Length) -> Sum/Length;
average_acc([H | T], Sum, Length) -> average_acc(T, Sum + H, Length + 1).
