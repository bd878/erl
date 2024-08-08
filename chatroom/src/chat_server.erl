-module(chat_server).
-export([start/0, init/0, loop/1, terminate/0]).

-record(state, {messages}).
-record(message, {ref, value}).

start() ->
  Pid = spawn(?MODULE, init, []),
  Pid.

terminate() ->
  ?MODULE ! shutdown.

init() ->
  loop(#state{messages=[]}).

loop(S = #state{}) ->
  Ref = make_ref(),

  receive
    {Pid, {status}} ->
      Pid ! ok,
      loop(S);

    {Pid, {post, Msg}} ->
      Messages = [#message{value=Msg, ref=Ref} | S#state.messages],
      Pid ! {ok, Ref},
      loop(S#state{messages=Messages});

    {Pid, {get, SearchRef}} ->
      Values = [Value || {MsgRef, Value} <- S#state.messages, MsgRef == SearchRef],
      Pid ! {ok, Values},
      loop(S);

    {Pid, {get_all}} ->
      Values = [M#message.value || M <- S#state.messages],
      Pid ! {ok, Values},
      loop(S);

    shutdown ->
      exit(shutdown);

    Unknown ->
      io:format("unknown message: ~p~n", [Unknown]),
      loop(S)
  end.
