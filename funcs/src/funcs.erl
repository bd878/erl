-module(funcs).
-export([map/2]).

map(_, []) -> [];
map(Fn, [H|T]) -> [Fn(H)|map(Fn, T)].
