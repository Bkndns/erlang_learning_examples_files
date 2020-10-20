-module(threads).
-export([start/0, say_smth/2]).

say_smth(What, 0) ->
	done;
say_smth(What, Times) ->
	io:format("~p~n", [What]),
	say_smth(What, Times-1).

start() ->
	spawn(threads, say_smth, [hello, 3]),
	spawn(threads, say_smth, [goodbye, 3]).
