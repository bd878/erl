-module(single_value).
-export([start/0, set_value/2, call/1, spawn_nodes/1,
  get_current/1, stop/1, set_value_multi/1, get_value_multi/0]).

-define(SERVER, ?MODULE).
-define(TIMEOUT, 1000).
-define(RPC_TIMEOUT, 2000).

%% @Constructor
spawn_nodes(Nodes) when erlang:is_list(Nodes) ->
  [spawn(Node, ?SERVER, start, []) || Node <- Nodes];
spawn_nodes(_) ->
  io:format("usage: ...node~n").

start() ->
  register(?SERVER, self()),
  init().

init() ->
  loop(0).

%% @Public
set_value(Node, NextValue) when erlang:is_integer(NextValue) ->
  remote_call(Node, {set_value, NextValue});
set_value(_Node, _Msg) ->
  {error, "value not an integer"}.
get_current(Node) ->
  remote_call(Node, get_current).
stop(Node) ->
  remote_call(Node, stop).

set_value_multi(NextValue) when erlang:is_integer(NextValue) ->
  remote_multi_call({set_value, NextValue});
set_value_multi(_) ->
  {error, "value not an integer"}.
get_value_multi() ->
  remote_multi_call(get_current).

%% @Private
remote_multi_call(Op) ->
  {Resl, _} = rpc:multicall(nodes(), ?SERVER, call, [Op], ?RPC_TIMEOUT),
  Resl.

call(Op) ->
  ?SERVER ! {request, self(), Op},
  receive
    {reply, Reply} -> Reply
  end.
 
remote_call(Node, Op) ->
  Ref = erlang:monitor(process, {?SERVER, Node}),
  {?SERVER, Node} ! {request, self(), Op},
  receive
    {reply, Reply} ->
      erlang:demonitor(Ref),
      Reply;
    {'DOWN', Ref, process, Pid, Reason} ->
      io:format("Process ~p on node ~p is down with the reason ~p~n", [Pid, Node, Reason]),
      Reason
  after ?TIMEOUT ->
    {error, timeout}
  end.

reply(To, Value) ->
  To ! {reply, Value}.
 
loop(Value) ->
  receive
    {request, From, {set_value, NextValue}}
        when erlang:is_integer(NextValue) ->
      reply(From, NextValue),
      loop(NextValue);
    {request, From, get_current} ->
      reply(From, Value),
      loop(Value);
    {request, From, stop} ->
      reply(From, ok);
    Unknown ->
      io:format("Unknown request ~p~n", [Unknown]),
      loop(Value)
  end.
