-module(records).
-export([admin_panel/1, adult_section/1]).
-record(user, {id, name, group, age}).

%% use pattern matching to filter
admin_panel(#user{name=Name, group=admin}) ->
  Name ++ " is allowed!";
admin_panel(#user{name=Name}) ->
  Name ++ " is not allowed.".

adult_section(U = #user{}) when U#user.age >= 18 ->
  %% Show stuff that can't be written in such a text
  allowed;
adult_section(_) ->
  forbidden.

repairmen(Rob) ->
  Details = Rob#robot.details,
  NewRob = Rob#robot{details=["repaired by repairmen"|Details]},
  {repaired, NewRob}.
