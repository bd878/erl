-ifdef(debug).
-define(LOG(X), io:format("{~p ~p}: ~p~n", [?MODULE, ?LINE, X])).
-else.
-define(LOG(X), true).
-endif.
