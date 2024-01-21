-module(timeouts).

% provided db process registered
read(Key) ->
  flush(),
  db ! {self(), {read, Key}},
  receive
    {read,R}        -> {ok, R};
    {error,Reason}  -> {error, Reason}
  after 1000        -> {error, timeout}
  end.

flush() ->
  receive
    {read, _}   -> flush();
    {error, _}  -> flush()
  after 0       -> ok
  end.

