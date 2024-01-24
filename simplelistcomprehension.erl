-module(simplelistcomprehension).
-export([gen/0, gen2/1]).

% [ Expression || Generators, Guards, Generators, ... ]
gen() -> [X+1 || X <- [1,2,3], X rem 2 == 0].

gen2(N) -> [ {X,Y} || X <- lists:seq(1,N), X rem 2 == 0, Y <- lists:seq(X, N) ].
