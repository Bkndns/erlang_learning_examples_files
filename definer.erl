-module(definer).
-export([minus/2, test_def/0]).

-define(HOUR, 3600).

-define(sub(X,Y), X-Y).

test_def() ->
	?HOUR.

minus(A, B) ->
	?sub(A,B).
