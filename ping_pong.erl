-module(ping_pong).
-export([start/0, ping/1, pong/0]).

ping(0) ->
    pong ! finished,
    io:format("Пинг завершил работу ~n", []);

ping(N) ->
    pong ! {ping, self()},
    receive
        pong ->
            io:format("Пинг принял сигнал понг ~n", [])
    end,
    ping(N - 1).

pong() ->
    receive
        finished ->
            io:format("Понг завершил выполнение ~n", []);
        {ping, Ping_PID} ->
            io:format("Понг получил сигнал Пинга ~n", []),
            Ping_PID ! pong,
            pong()
    end.

start() ->
    register(pong, spawn(ping_pong, pong, [])),
    spawn(ping_pong, ping, [3]).