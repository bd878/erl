#!/usr/bin/env escript
%% -*- erlang -*-

proc() ->
  receive
    {Message, From} ->
      From ! {string:uppercase(Message), self()}
  end.

main(_) ->
  Pid = spawn_link(fun() -> proc() end),
  io:format("New proc: ~p~n", [Pid]),
  Pid ! {"test", self()},
  receive
    {Response, Pid} ->
      io:format("Response: ~p~n", [Response]);
    Unknown ->
      io:format("received unknown message: ~p~n", [Unknown])
  end.
  
