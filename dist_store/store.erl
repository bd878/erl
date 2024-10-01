-module(store).
-export([start/0]).

-define(SERVER, ?MODULE).

%% Constructor

start() ->
  register(?SERVER, self()),
  init().

%% Public
store(Key, Value) ->
  ?SERVER ! .

%% Private
init() ->
  loop(dict:new()).

loop(D) ->
  receive
    {}
  end.
