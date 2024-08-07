#!/usr/bin/env escript
%% -*- erlang -*-
%%! -sname list_riak_keys -mnesia debug verbose

main(_) ->
  {ok, Pid} = riakc_pb_socket:start_link("127.0.0.1", 8087),
  {ok, Keys} = riakc_pb_socket:list_keys(Pid, <<"training">>),
  lists:foreach(fun(Key) -> io:format("~p~n", [Key]) end, Keys).

