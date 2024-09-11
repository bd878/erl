-module(m8ball_sup).
-behaviour(supervisor).
-export([start_link/0, init/1]).

start_link() ->
  supervisor:start_link({global, ?MODULE}, ?MODULE, []).

init([]) ->
  SupFlags = #{strategy => one_for_one,
               intensity => 10,
               period => 5},
  ChildSpec = #{id => m8ball,
                start => {m8ball_server, start_link, []},
                restart => temporary,
                significant => false,
                shutdown => 5000,
                type => worker},
  {ok, {SupFlags, [ChildSpec]}}.
