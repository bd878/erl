-module(standardcomprehension).
-export([map/2,filter/2,append/1,perms/1,splits/1,insert/3]).

map(F,Xs) -> [ F(X) || X <- Xs].
filter(P,Xs) -> [ X || X <- Xs, P(X) ].
append(Xss) -> [ X || Xs <- Xss, X <- Xs].

perms([]) -> [[]];
perms([X|Xs]) ->
  [ insert(X, As, Bs) || Ps <- perms(Xs),
    {As,Bs} <- splits(Ps) ].

splits([]) -> [{[],[]}];
splits([X|Xs] = Ys) ->
  [ {[],Ys} | [ { [X|As], Bs } || {As, Bs} <- splits(Xs) ] ].

insert(X, As, Bs) ->
  lists:append([As,[X],Bs]).
