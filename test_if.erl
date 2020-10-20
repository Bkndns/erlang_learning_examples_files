-module(test_if).
-export([test_if/2]).

test_if(A, B) ->
	if
		A == 5 ->
			io:format("A = 5~n", []);
		B == 6 ->
			io:format("B = 6~n", []);
		A == 2, B == 3 ->
			io:format("A == 2, B == 3~n", []);
		A == 1; B == 7 -> % A eq 1 OR B eq 7
			io:format("A == 1; B == 7~n", [])
	end.
