-module(trade_fsm).
-behaviour(gen_statem).

%% public API
-export([start/1]).
%% gen_fsm callbacks
-export([init/1]).

-record(state, {name=""}).

start(Name) ->
  gen_statem:start(?MODULE, [Name], []).

init(Name) ->
  {ok, idle, #state{name=Name}}.


