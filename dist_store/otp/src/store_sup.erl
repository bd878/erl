-module(store_sup).
-behaviour(supervisor).
-export([start_link/0, init/1]).

start_link() ->
  supervisor:start_link(?MODULE, []).

init([]) ->
  SupFlags = #{strategy => one_for_one,
               intensity => 5,
               period => 100},
  ChildSpec = #{id => store_server,
                start => {store_server, start_link, []},
                restart => transient,
                shutdown => brutal_kill,
                type => worker,
                modules => [store_server]},
  {ok, {SupFlags, [ChildSpec]}}.
