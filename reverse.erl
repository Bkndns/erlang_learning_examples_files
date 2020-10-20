-module(reverse).
-export([reverse/1]).

reverse(List) ->
	reverse(List, []).

reverse([Head | Rest], RevList) ->
	reverse(Rest, [Head | RevList]);
reverse([], RevList) ->
	RevList.
