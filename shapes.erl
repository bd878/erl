-module(shapes).
-import(math, [sqrt/1]).
-export([area/1]).

area({triangle, A, B, C}) ->
  S = (A + B + C)/2,
  sqrt(S*(S-A)*(S-B)*(S-C)).
