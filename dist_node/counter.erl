-module(counter).
-export([start_link/0, start_link/1, stop/0, inc/0, dec/0, counter/0]).
-export([init/1]).

-define(TIMEOUT, 10000).
-define(COUNT, 0).

%% Constructor

start_link() ->
  register(?MODULE, Pid=spawn_link(?MODULE, init, [?TIMEOUT])),
  Pid.
start_link(Timeout) ->
  register(?MODULE, Pid=spawn_link(?MODULE, init, [Timeout])),
  Pid.

init(Timeout) ->
  process_flag(trap_exit, true),
  loop(?COUNT, Timeout).

%% Interface

stop() -> call(stop).
inc() -> call(inc).
dec() -> call(dec).
counter() -> call(counter).

%% Hide all message passing and the message
%% protocol in a functional interface

%% Internal

call(Message) ->
  ?MODULE ! {request, self(), Message},
  receive
    {reply, Reply} -> Reply
  end.

reply(Pid, Reply) ->
  Pid ! {reply, Reply}.

loop(Counter, Timeout) when erlang:is_integer(Timeout) ->
  receive
    {'EXIT', Pid, Reason} ->
      io:format("Exit with the reason: ~p~n", [Reason]),
      reply(Pid, Reason);
    {request, Pid, inc} ->
      reply(Pid, ok),
      loop(Counter+1, Timeout);
    {request, Pid, dec} ->
      reply(Pid, ok),
      loop(Counter-1, Timeout);
    {request, Pid, counter} ->
      reply(Pid, Counter),
      loop(Counter, Timeout);
    {request, Pid, stop} ->
      reply(Pid, exit),
      exit(stop)
  after Timeout ->
    exit(timeout)
  end.
