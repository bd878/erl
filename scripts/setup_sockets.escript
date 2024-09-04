#!/usr/bin/env escript
%% -*- erlang -*-

loop(Sock) ->
  case gen_tcp:recv(Sock, 0) of
    {ok, Packet} ->
      io:format("Packet: ~p~n", [Packet]),
      gen_tcp:send(Sock, Packet),
      loop(Sock);
    {error, Reason} ->
      io:format("Failed to recv: ~p~n", [Reason]),
      gen_tcp:close(Sock)
  end.

accept(ListenSock) ->
  case gen_tcp:accept(ListenSock) of
    {ok, S} ->
      spawn(fun() ->
        io:format("New connection on remote peer: ~p~n", [inet:peername(S)]),
        loop(S)
      end),
      accept(ListenSock);
    {error, Reason} ->
      io:format("Listening sock failed for a reason: ~p~n", [Reason])
  end.

server(Port) ->
  case gen_tcp:listen(Port, [binary, {active, false}, {packet, raw}]) of
    {ok, ListenSock} ->
      accept(ListenSock);
    {error, Reason} ->
      io:format("failed to listen: ~p~n", [Reason])
  end.

main(_) ->
  spawn(fun() -> server(8743) end),
  case gen_tcp:connect("localhost", 8743, [{active, false}, {packet, 0}]) of
    {ok, Sock} ->
      gen_tcp:send(Sock, <<1,0,0,1>>),
      A = gen_tcp:recv(Sock, 0),
      io:format("Answer: ~p~n", [A]),
      gen_tcp:close(Sock);
    {error, Reason} ->
      io:format("failed to connect: ~p~n", [Reason])
  end.

