-module(client).
-export([remote_call/2,remote_call_timeout/2]).

remote_call(Message, Node) ->
  {facserver, Node} ! {self(), Message},
  receive
    {ok, Res} ->
      Res
  end.

remote_call_timeout(Message, Node) ->
  monitor_node(Node, true),
  {facserver, Node} ! {self(), Message},
  receive
    {ok, Res} ->
      monitor_node(Node,false),
      Res;
    {nodedown,Node} ->
      {error, node_down}
    after 1000 ->
      {error, timeout}
  end.
