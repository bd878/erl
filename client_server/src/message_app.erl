-module(message_app).
-behaviour(application).
-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
  io:format("message_app trying to start~n"),
  message_sup:start_link().

stop(_) ->
  ok.
