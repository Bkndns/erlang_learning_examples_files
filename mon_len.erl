-module(mon_len).
-export([mon_len/2]).

mon_len(Y, M) ->
	%% Все годы, делящиеся на 400 - високосные
	%% Годы, делящиеся на 100 – не високосные(кроме тех, что делятся на 400)
	%% Годы, делящиеся на 4 не високосные(кроме тех, что делятся на 100)
		Leap = if
			trunc(Y / 400) * 400 == Y ->
				leap;
			trunc(Y / 100) * 100 == Y ->
				not_leap;
			trunc(Y / 4) * 4 == Y ->
				leap;
			true ->
				not_leap
		end,
		case M of
			sep -> 30;
			apr -> 30;
			jun -> 30;
			nov -> 30;
			feb when Leap == leap -> 29;
			feb -> 28;
			jan -> 31;
			mar -> 31;
			may -> 31;
			jul -> 31;
			aug -> 31;
			oct -> 31;
			dec -> 31
		end.
