-module(main_log).
-export([log/1]).
-include("./log_macros.hrl").

log(X) ->
  ?LOG(X).
