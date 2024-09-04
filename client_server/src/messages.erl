-module(messages).
-behaviour(application).
-export([start/2, stop/1]).
-export([get_time/0, send/1, dump/0]).

start(normal, _StartArgs) ->
  messages_sup:start_link().

stop(_) ->
  ok.

%%% INTERFACE
get_time() ->
  messages_server:get_time().

send(Value) ->
  messages_server:send_message(Value).

dump() ->
  messages_server:dump_messages().
