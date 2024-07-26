-module(erlcount_sup).
-behaviour(supervisor).
-export([start_link/0, init/1]).

-define(SERVER, ?MODULE).

start_link() ->
  supervisor:start_link(?SERVER, []).

init([]) ->
  SupFlags = #{strategy => one_for_one,
               intensity => 5,
               period => 100},
  ChildSpec = [#{id => dispatch,
                 start => {erlcount_dispatch, start_link, []},
                 restart => transient,
                 type => worker,
                 shutdown => 60000,
                 modules => [erlcount_dispatch]}],
  {ok, {SupFlags, ChildSpec}}.
