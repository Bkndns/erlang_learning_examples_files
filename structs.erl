-module(structs).
-export([included/0, mrpilotman/1, test_struct/0, car_factory/1, admin_panel/1, adult_section/1]).

-record(robot, {name, hobbies, type=industrial, details=[]}).

test_struct() ->
    #robot{name="Mehanotron", type=handmade, details=["Bip bup im machine"]}.

car_factory(CorpName) ->
    #robot{name=CorpName, hobbies="автомобили"}.

-record(user, {id, name, group, age}).

admin_panel(#user{name=Name, group=admin}) ->
    Name ++ " is allowed";
admin_panel(#user{name=Name}) ->
    Name ++ " is not allowed".

adult_section(U = #user{}) when U#user.age > 18 ->
    allowed;
adult_section(_) ->
    forbiden.

mrpilotman(Pilot) ->
    Details = Pilot#robot.details,
    NewRob = Pilot#robot{details=["REPAIR!!! BENZIIIIIN!!!" | Details]},
    {repaired, NewRob}.