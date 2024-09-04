-module(messages_server).
-behaviour(gen_server).
-export([init/1, handle_call/3, handle_cast/2, terminate/2]).
-export([start_link/0, stop/0, get_time/0, send_message/1, dump_messages/0]).

-record(state, {message_queue=[]}).

start_link() ->
  gen_server:start_link({local, messages_server}, ?MODULE, [], []).

init(_) ->
  {ok, #state{message_queue=[]}}.

handle_call(time, _From, S) ->
  {reply, calendar:local_time(), S};
handle_call(dump, _From, S) ->
  {reply, S, S};
handle_call({message, Value}, _From, S) ->
  NewQueue = S#state.message_queue ++ [Value],
  {reply, ok, #state{message_queue=NewQueue}}.

handle_cast(stop, State) ->
  {stop, by_request, State}.

terminate(_Reason, _State) ->
  ok.

stop() ->
  gen_server:cast(messages_server, stop).

get_time() ->
  gen_server:call(messages_server, time).

send_message(Value) ->
  gen_server:call(messages_server, {message, Value}).

dump_messages() ->
  gen_server:call(messages_server, dump).
