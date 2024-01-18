-module(factorial).
-export([factorial/1,guard/2]).

factorial(N) when N > 0 ->
  N * factorial(N-1);
factorial(0) -> 1;

guard(X,Y) when not(((X>Y) or not(is_atom(X)) ) and (is_atom(X) or (X==3.14))) ->
  X+Y;
guard2(X,Y) when not(X>Y),is_atom(X) ; not(is_atom(Y)) , X=/=3.14 ->
  X+Y.
