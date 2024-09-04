-module(nums).
-export([start/0, init/0, second/1,
  print_date_time/1, divisor/1, add_int/2]).

%%% Creates a link to a process,
%%% that appends new item to a list
start() ->
  Pid = spawn_link(?MODULE, init, []),
  Pid.
  
init() ->
  loop([]).

loop(L) ->
  receive
    {'add', Pid, Num} ->
      Pid ! 'ok',
      loop(L++[Num]);
    {'get', Pid} ->
      Pid ! L,
      loop(L);
    Unknown ->
      io:format("Unknown message: ~p~n", [Unknown])
  end.

%%% Returns second value from head
%%% in list, or just head 
second([_,X|_]) -> X;
second([H|_]) -> H.

%%% Prints well-formed date
print_date_time({Date = {Y,M,D}, Time = {H,Min,S}})
  when D =< 31, H =< 24, Min =< 60, S =< 60 ->
  io:format("Date tuple: ~p: ~p/~p/~p,~n", [Date, Y, M, D]),
  io:format("Time tuple: ~p: ~p:~p:~p,~n", [Time, H, Min, S]);
print_date_time(_) ->
  io:format("Malformed date/time~n").

%%% Returns number's least leap divisor
%%% among hard-coded numbers
divisor(Num) ->
  if Num rem 2 == 0 -> 2;
     Num rem 3 == 0 -> 3;
     Num rem 5 == 0 -> 5;
     Num rem 7 == 0 -> 7;
     Num rem 11 == 0 -> 11;
     true ->
       io:format("Num ~p has no known leap divisors~n", [Num])
  end.

%%% Adds integer to the list only.
%%% Otherwise, prints error
add_int(N, L) when is_integer(N) ->
  L++[N];
add_int(N, _) ->
  io:format("~p not an integer~n", [N]).
