-module(http_handler).
-behaviour(gen_server).
-export([start_link/0, stop/0, init/1, terminate/2, handle_call/3,
         handle_cast/2]).

%%% INTERFACE
start_link() ->
  gen_server:start_link({global, ?MODULE}, ?MODULE, [], []).

stop() ->
  gen_server:stop({global, ?MODULE}).

%%% CALLBACK
init(_State) ->
  {ok, []}.

handle_call(test, _From, State) ->
  {reply, test, State};
handle_call(stop, _From, State) ->
  {stop, normal, ok, State}.

handle_cast(_Any, State) ->
  {noreply, State}.

terminate(_Reason, _State) ->
  ok.
