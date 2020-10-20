-module(ping_pong_par).
-export([start_ping/1, start_pong/0,  ping/2, pong/0]).

ping(0, Pong_Node) ->
    {pong, Pong_Node} ! finished,
    io:format("Пинг завершил работу ~n", []);

ping(N, Pong_Node) ->
    {pong, Pong_Node} ! {ping, self()},
    receive
        pong ->
            io:format("Пинг принял сигнал понг ~n", [])
    end,
    ping(N - 1, Pong_Node).

pong() ->
    receive
        finished ->
            io:format("Понг завершил выполнение ~n", []);
        {ping, Ping_PID} ->
            io:format("Понг получил сигнал Пинга ~n", []),
            Ping_PID ! pong,
            pong()
        after 5000 ->
            io:format("Понг отвалился по таймауту~n", [])
    end.

start_pong() ->
    register(pong, spawn(ping_pong_par, pong, [])).

start_ping(Pong_Node) ->
    spawn(tut17, ping, [3, Pong_Node]).