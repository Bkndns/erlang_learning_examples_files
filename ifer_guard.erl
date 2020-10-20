-module(ifer_guard).
-export([ifer/2]).
-export([list_max/1]).

ifer(Integer, Eq) when Integer > Eq ->
	io:format("~w > ~w ~n", [Integer, Eq]);
ifer(Integer, Eq) when Integer == Eq ->
	io:format("~w == ~w ~n", [Integer, Eq]);
ifer(Integer, Eq) when Integer < Eq ->
	io:format("~w < ~w ~n", [Integer, Eq]).

