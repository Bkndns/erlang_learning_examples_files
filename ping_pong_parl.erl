-module(ping_pong_parl).
-export([start/1, ping/2, pong/0]).

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
    end.

start(Ping_Node) ->
    register(pong, spawn(ping_pong_parl, pong, [])),
    spawn(Ping_Node, ping_pong_parl, ping, [3, node()]).