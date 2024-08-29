-module(message_sup).
-behaviour(supervisor).
-export([init/1, start_link/0]).

start_link() ->
  io:format("starting message_sup~n"),
  supervisor:start_link({local, message_sup}, ?MODULE, []).

init([]) ->
  SupFlags = #{strategy => one_for_one,
               intensity => 1,
               period => 100},
  ChildSpec = [#{id => server,
                 start => {message_server, start_link, []},
                 restart => transient,
                 shutdown => infinity,
                 type => worker,
                 modules => [message_server]}],
  {ok, {SupFlags, ChildSpec}}.
