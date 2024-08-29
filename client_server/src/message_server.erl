-module(message_server).
-behaviour(gen_server).
-export([init/1, handle_call/3, handle_cast/2, terminate/2]).
-export([start_link/0, stop/0, get_time/0]).

-record(state, {message_queue=[]}).

start_link() ->
  gen_server:start_link({local, message_server}, ?MODULE, [], []).

init(_) ->
  {ok, #state{message_queue=[]}}.

handle_call(time, _From, State) ->
  {reply, calendar:local_time(), State};
handle_call(dump, _From, State) ->
  {reply, State, State};
handle_call({message, Value}, _From, State) ->
  NewState = State ++ [Value],
  {reply, ok, NewState}.

handle_cast(stop, State) ->
  {stop, by_request, State}.

terminate(_Reason, _State) ->
  ok.

stop() ->
  gen_server:cast(message_server, stop).

get_time() ->
  gen_server:call(message_server, time).
  
