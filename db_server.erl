-module(db_server).
-export([start/0, init/0]).

% what if two processes
% start executing start() concurrently?
% first proc enteres undefined but preempted
% exactly on registering db_server.
% Second is succeeded to register it.
% When first resumed, it fails runtime
% on registering db_server. We expect rather
% already_started error
start() ->
  case whereis(db_server) of
    undefined ->
      Pid = spawn(db_server, init, []),
      register(db_server, Pid),
      {ok, Pid};
    Pid when is_pid(Pid) ->
      {error, already_started}
  end.

init() ->
  receive
  after
    1000 -> ok
  end.
