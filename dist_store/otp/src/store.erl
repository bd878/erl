-module(store).
-behaviour(application).
-export([start/2, stop/1, append/2, fetch/1]).

start(normal, _Args) ->
  store_sup:start_link().

stop(_State) ->
  ok.

append(Key, Value) ->
  store_server:append(Key, Value).
fetch(Key) ->
  store_server:fetch(Key).
