-module(http_server).
-behaviour(application).
-export([start/2, stop/1]).

%%% CALLBACKS
start(normal, Args) ->
  http_server_sup:start_link(Args).
stop(_State) -> ok.
