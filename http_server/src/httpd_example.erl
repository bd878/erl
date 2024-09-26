-module(httpd_example).
-export([example/3]).

example(SessionID, _Env, _Input) ->
  mod_esi:deliver(SessionID, [<<"test example">>]). 
