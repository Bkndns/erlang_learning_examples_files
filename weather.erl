-module(weather).
-export([format_temps/1]).
-export([convert_list_to_c/1]).

% Дальше код самой программы


format_temps([]) ->
	ok;

format_temps([City | Rest]) ->
	print_temp(convert_to_celsius(City)),
	format_temps(Rest).


% Конвертация не нужна
convert_to_celsius({Name, {c, Temp}}) ->
	{Name, {c, Temp}};
% Выполнить конвертацию
convert_to_celsius({Name, {f, Temp}}) -> 
	{Name, {c, (Temp - 32) * 5 / 9}}.

print_temp({Name, {c, Temp}}) ->
	io:format("~-20w ~w c~n", [Name, Temp]).

convert_list_to_c(List) ->
	Sorter = fun( { _, {c, Temp1} } , { _, {c, Temp2} } ) -> Temp1 < Temp2 end,
	New_list = lists:map(fun convert_to_celsius/1, List),
	lists:sort(Sorter, New_list).
