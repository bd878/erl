-module(store_server).
-behaviour(gen_server).

-export([init/1, handle_call/3, handle_cast/2, terminate/2]).
-export([start_link/0, append/2, fetch/1]).

-define(SERVER, ?MODULE).
-define(TIMEOUT, 5000).

%%% INTERFACE

start_link() ->
  gen_server:start_link({local, ?SERVER}, ?SERVER, [], []).

append(Key, Value) ->
  gen_server:call(?SERVER, {append, {Key, Value}}).
fetch(Key) ->
  gen_server:call(?SERVER, {fetch, Key}).

%%% CALLBACKS

init(_Args) ->
  {ok, dict:new()}.

handle_call({fetch, Key}, _From, State) ->
  Value = dict:fetch(Key, State),
  {reply, Value, State};
handle_call({append, {Key, Value}}, _From, State) ->
  NextState = dict:append(Key, Value, State),
  {reply, ok, NextState}.

handle_cast(_Request, State) ->
  {noreply, State}.

terminate(_Reason, _State) ->
  ok.
