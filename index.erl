-module(index).
-export([index/2]).
-export([index_case/2]).

index(X,Y) ->
  index({X,Y}).

index(Z) ->
  case Z of
    {0,[X|_]} -> X;
    {N,[_|Xs]} when N>0 -> index(N-1,Xs)
  end.

index_case(X,Y) ->
  case X of
    0 ->
      case Y of
        [Z|_] -> Z
      end;
    N when N>0 ->
      case Y of
        [_|Zs] -> index(N-1,Zs)
      end
  end.
