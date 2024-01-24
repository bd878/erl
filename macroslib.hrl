-ifdef(debug).
  -define(DBG(Str, Args), io:format(Str, Args)).
-else.
  -define(DBG(Str, Args), ok).
-endif.

-define(FUNC,X).
-define(TION,+X).
-define(Multiple(X,Y),X rem Y == 0).

%-define(DBG(Str,Args), ok).
%-define(DBG(Str,Args), io:format(Str,Args)).

-define(VALUE(Call),io:format("~p = ~p~n",[??Call,Call])).

