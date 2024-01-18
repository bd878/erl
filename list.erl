-module(list).
-export([bump/1, average/1]).

bump([]) -> [];
bump([Head | Tail]) -> [Head + 1 | bump(Tail)].

average(List) -> sum(List) / len(List).

sum([]) -> 0;
sum([Head | Tail]) -> Head + sum(Tail).

len([]) -> 0;
len([_ | Tail]) -> 1 + len(Tail).
