-module(boolean).
-export([b_not/1]).

b_not(false) ->
  true ;
b_not(true) ->
  false ;
