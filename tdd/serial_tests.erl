-module(serial_tests).
-include_lib("eunit/include/eunit.hrl").
-import(serial,
  [treeToList/1,listToTree/1,
    tree0/0, tree1/0]).

%% Tests geerator function
leaf_value_test_() ->
  fun () -> ?assertEqual([2,ant], treeToList(tree0())) end.

leaf_test() ->
  ?assertEqual(tree0(), listToTree(treeToList(tree0()))).
node_list() ->
  ?assertEqual(tree1(), listToTree(treeToList(tree1()))).
leaf_value_test1() ->
  ?assertEqual([2,ant], treeToList(tree0())).
node_value_test() ->
  ?assertEqual([11,8,2,cat,5,2,dog,2,emu,2,fish], treeToList(tree1())).

leaf_negative_test1() ->
  ?assertError(badarg, listToTree([1,ant])).
node_negative_test1() ->
  ?assertError(badarg, listToTree([8,6,2,cat,2,dog,emu,fish])).

% serual_tests:test() or eunit:test(serial_tests)

setup1_test_() ->
  {spawn,
    {setup,
      fun () -> create_tables("UsrTabFile") end,      % setup
      fun (_) -> ?cmd("rm UsrTabFile") end,           % cleanup
      ?_assertMatch({error,instance}, lookup_id(1))
    }
  }.

setup2_test_() ->
  {spawn,
    {setup,
      fun() ->
        create_tables("UsrTabFile"),
        Seq = lists:seq(1,100000),
        Add = fun(Id) -> add_usr(#usr{msisdn = 7000000000 + Id,
                                      id = Id,
                                      plan = prepay,
                                      services = [data, sms, lbs]})
              end,
        lists:foreach(Add, Seq)
      end,
      fun (_) -> ?cmd("rm UsrTabFile") end,
      ?_assertMatch({ok, #usr{status = enabled}}, lookup_msisdn(7000000001) )
    }
  }.
