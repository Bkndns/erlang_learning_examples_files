-module(filter_map_foldl).
-compile(export_all).

get_users() ->
    [{user, 1, "Bob", male, 22},
         {user, 2, "Helen", female, 18},
         {user, 3, "Bill", male, 12},
         {user, 4, "Kate", female, 17}].

get_females(User) ->
    lists:filter(fun({user, _, _, Gender, _}) -> Gender =:= female end, User).

get_id_name(User) ->
    lists:map(fun({user, Id, Name, _, _}) -> {Id, Name} end, User).

get_fem_id_name(User) ->
    lists:filtermap(
        fun({user, _Id, _Name, male, _}) -> false;
    ({user, Id, Name, female, _}) -> {true, {Id, Name}}
    end, User).

get_stat(User) ->
    lists:foldl(
        fun({user, _, _, Gender, Age}, {NFem, NMale, NTotal, NAge}) ->
            case Gender of
                female -> {NFem + 1, NMale, NTotal + 1, NAge + Age};
                male -> {NFem, NMale + 1, NTotal + 1, NAge + Age}
            end
        end,
        {0,0,0,0},
        User).
        

split_by_age(User) ->
    lists:foldl(fun({user, _,_,_, Age} = Usero, {Acc1, Acc2}) ->
        if
            Age < 18 -> {[Usero | Acc1], Acc2};
            true -> {Acc1, [Usero | Acc2]}
        end
    end,
    {[], []},
    User).

        