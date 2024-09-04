#!/usr/bin/env escript
%% -*- erlang -*-

main(_) ->
  IntStr = <<1, 2, 3, 4, 5, 6, 7, 8>>,
  Pixels = <<213,45,132,64,76,32,76,0,0,234,32,15>>,

  MapBits = fun() ->
    <<FirstBits:16, SecondBits:16, RestBits/binary>> = IntStr,
    io:format("First: ~p, Second: ~p, Third: ~p~n", [FirstBits, SecondBits, RestBits])
  end,

  MapIntegers = fun() ->
    <<FirstInt/utf16, SecondInt/utf16, RestBits/binary>> = IntStr,
    io:format("FirstInt: ~p, SecondInt: ~p, Rest...: ~p~n", [FirstInt, SecondInt, RestBits])
  end,

  Unpack = fun() ->
    <<Pix1:24, Pix2:24, Pix3:24, Pix4:24>> = Pixels,
    io:format("~p, ~p, ~p, ~p~n", [Pix1, Pix2, Pix3, Pix4])
  end,

  Unpack().

