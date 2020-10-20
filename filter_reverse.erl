-module(filter_reverse).
-export([get_users/0, filter_fem/1, sort_age/1, get_id_name/1, reversio/1]).

get_users() ->
    [{user, 1, "Bob", male, 22},
         {user, 2, "Helen", female, 18},
         {user, 3, "Bill", male, 12},
         {user, 4, "Kate", female, 17}].

filter_fem(Users) -> filter_fem(Users, []).
filter_fem([], Acc) -> lists:reverse(Acc);
filter_fem([User | Rest], Acc) ->
    case User of
        {user, _, _, male, _} -> filter_fem(Rest, Acc);
        {user, _, _, female, _} -> filter_fem(Rest, [User | Acc])
    end.

sort_age(User) -> sort_age(User, {[], []}).
sort_age([], {Acc1, Acc2}) -> {lists:reverse(Acc1), lists:reverse(Acc2)};
sort_age([User | Rest], {Acc1, Acc2}) ->
    {user, _, _, _, Age} = User,
    if
        Age < 18 -> sort_age(Rest, {[User | Acc1], Acc2});
        true -> sort_age(Rest, {Acc1, [User | Acc2]})
    end.

get_id_name(User) -> get_id_name(User, []).
get_id_name([], Acc) -> lists:reverse(Acc);
get_id_name([User | Rest], Acc) ->
    {user, Id, Name, _, _} = User,
    get_id_name(Rest, [{Id, Name} | Acc]).

reversio(List) -> reversio(List, []).
reversio([], Acc) -> Acc;
reversio([H | T], Acc) ->
    reversio(T, [H | Acc]).