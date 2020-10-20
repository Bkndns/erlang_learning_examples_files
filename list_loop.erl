-module(list_loop).
-export([start/0, loop/1]).

start() ->
    InitState = 0,
    spawn(?MODULE, loop, [InitState]).

loop(State) ->
    receive
        {add, Item} -> io:format("~p I Addd Item ~p ~n", [self(), Item]), NState = [Item | State], ?MODULE:loop(NState);
        {remove, Item} -> NewState = case lists:member(Item, State) of
                                        true -> lists:delete(Item, State);
                                        false -> io:format("I have no ~p~n", [Item]), State
                                    end,
                              ?MODULE:loop(NewState);
        show -> io:format("my items ~p~n", [State]), ?MODULE:loop(State);
        stop -> io:format("~p stops now ~n", [self()]);
        _Any -> ?MODULE:loop(State)
    end.