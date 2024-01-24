-module(macro).
-export([double/1,test1/0,tstFun/2,birthday/1]).
-include("macroslib.hrl").

-record(person, {name,age=0,phone}).

test1() -> ?VALUE(length([1,2,3])).

double(X) -> ?FUNC?TION.

tstFun(Z,W) when ?Multiple(Z,W) -> true;
tstFun(_,_)                     -> false.

birthday(#person{age=Age} = P) ->
  ?DBG("in records1:birthday(~p)~n", [P]),
  P#person{age=Age+1}.
