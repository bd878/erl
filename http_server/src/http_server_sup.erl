-module(http_server_sup).
-behaviour(supervisor).
-export([start_link/1, init/1]).

%%% INTERFACE
start_link(Args) ->
  supervisor:start_link({global, ?MODULE}, ?MODULE, Args).

%%% CALLBACK
init(_Args) ->
  SupFlags = #{strategy => one_for_one,
               intensity => 10,
               period => 6},
  ChildSpec = #{id => http_handler,
                start => {http_handler, start_link, []},
                restart => temporary,
                significant => false,
                shutdown => 5000,
                type => worker},
  {ok, {SupFlags, [ChildSpec]}}.
  
  
