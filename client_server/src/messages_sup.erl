-module(messages_sup).
-behaviour(supervisor).
-export([init/1, start_link/0]).

start_link() ->
  supervisor:start_link({local, messages_sup}, ?MODULE, []).

init([]) ->
  SupFlags = #{strategy => one_for_one,
               intensity => 1,
               period => 100},
  ChildSpec = [#{id => server,
                 start => {messages_server, start_link, []},
                 restart => transient,
                 shutdown => infinity,
                 type => worker,
                 modules => [messages_server]}],
  {ok, {SupFlags, ChildSpec}}.
