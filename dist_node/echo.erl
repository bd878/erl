-module(echo).
-export([start/0, remote_call_timeout/2, remote_call_monitor/2]).
-export([init/0]).

-define(SERVER, ?MODULE).

start() ->
  register(?SERVER, self()),
  init().

init() ->
  loop().

reply(Pid, Message) ->
  Pid ! {reply, Message}.

loop() ->
  receive
    {stop, Pid} ->
      reply(Pid, ok);
    {Message, Pid} ->
      reply(Pid, Message),
      loop()
  end.

remote_call_timeout(Message, Node) ->
  {echo, Node} ! {Message, self()},
  receive
    {reply, Resp} ->
      Resp
  after 1000 ->
    {error, timeout}
  end.

remote_call_monitor(Message, Node) ->
  monitor_node(Node, true),
  {echo, Node} ! {Message, self()},
  receive
    {reply, Res} ->
      monitor_node(Node, false),
      Res;
    {nodedown, Node} ->
      {error, node_down}
  end.
