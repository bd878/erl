-module(dist_store).
-export([start/0, call/1, spawn_nodes/1]).
-export([append/2, fetch/1, stop/0]).

-define(SERVER, ?MODULE).
-define(TIMEOUT, 1000).
-define(RPC_TIMEOUT, 2000).

%% @Constructor
spawn_nodes(Nodes) when erlang:is_list(Nodes) ->
  setup_nodes(Nodes, []);
spawn_nodes(_) ->
  io:format("usage: ...node~n").

setup_nodes([], Acc) -> Acc;
setup_nodes([Node|Nodes], Acc) ->
  Refs = spawn_monitor(Node, ?SERVER, start, []),
  setup_nodes(Nodes, lists:append([Refs], Acc)).

start() ->
  register(?SERVER, self()),
  init().

init() ->
  loop(dict:new()).

%% @Public
append(Tag, Value) ->
  remote_multi_call({append, Tag, Value}).
fetch(Tag) ->
  remote_multi_call({fetch, Tag}).
stop() ->
  remote_multi_call(stop).

%% @Private
remote_multi_call(Op) ->
  {Resl, BadNodes} = rpc:multicall(nodes(), ?SERVER, call, [Op], ?RPC_TIMEOUT),
  if 
    erlang:length(BadNodes) > 0 ->
      io:format("Some nodes have failed: ~p~n", [BadNodes]);
    erlang:length(BadNodes) == 0 ->
      io:format("ok~n")
  end,
  Resl.

call(Op) ->
  ?SERVER ! {request, self(), Op},
  receive
    {reply, Reply} -> Reply
  end.

reply(To, Value) ->
  To ! {reply, Value}.
 
loop(D) ->
  receive
    {request, From, {append, Tag, Value}} ->
      reply(From, {Tag, Value}),
      loop(dict:append(Tag, Value, D));
    {request, From, {fetch, Tag}} ->
      case dict:find(Tag, D) of
        {ok, Value} ->
          reply(From, Value);
        error ->
          reply(From, error)
      end,
      loop(D);
    {request, From, stop} ->
      reply(From, ok);
    Unknown ->
      io:format("Unknown request ~p~n", [Unknown]),
      loop(D)
  end.
