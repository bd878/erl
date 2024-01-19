-module(exception).
-export([return_error/1,try_return/1]).

return_error(X) when X < 0 ->
  throw({'EXIT', {badarith,
    [{exception,return_error,1},
     {erl_eval,do_apply,5}]}});
return_error(X) when X == 0 ->
  1/X;
return_error(X) when X > 0 ->
  {'EXIT', {badarith, [{exception,return_error,1}]}}.

try_return(X) when is_integer(X) ->
  try return_error(X) of
    Val -> {normal,Val}
  catch
    exit:Reason -> {exit,Reason};
    throw:Throw -> {throw,Throw};
    error:Error -> {error,Error}
  end.
