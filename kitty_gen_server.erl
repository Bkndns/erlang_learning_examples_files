-module(kitty_gen_server).
-export([start_link/0, order_cat/4, return_cat/2, close_shop/1]).
-export([init/1, handle_call/3, handle_cast/2]).

-record(cat, {name, color=green, description}).

start_link() -> my_server:start_link(?MODULE, []).

return_cat(Pid, Cat = #cat{}) ->
    my_server:cast(Pid, {return, Cat}).

init([]) -> [].

make_cat(Name, Col, Desc) ->
    #cat{name=Name, color=Col, description=Desc}.

terminate(Cats) ->
    [io:format("~p был выпущен~n", [C#cat.name]) || C <- Cats],
    exit(normal).


order_cat(Pid, Name, Color, Description) ->
    my_server:order_cat(Pid, Name, Color, Description).


close_shop(Pid) ->
    my_server:call(Pid, terminate).

handle_call({order, Name, Color, Description}, From, Cats) ->
    io:format("тут 1~n", []),
    if Cats =:= [] ->
        io:format("тут 2~n", []),
        my_server:reply(From, make_cat(Name, Color, Description)),
        io:format("тут 3~n", []),
        Cats;
    Cats =/= [] ->
        io:format("тут 4~n", []),
        my_server:reply(From, hd(Cats)),
        io:format("тут 5~n", []),
        tl(Cats)
    end;

handle_call(terminate, From, Cats) ->
    my_server:reply(From, ok),
    terminate(Cats).

handle_cast({return, Cat = #cat{}}, Cats) ->
    [Cat|Cats].

% loop(Cats) ->
%     receive
%         {Pid, Ref, {order, Name, Color, Description}} ->
%             if Cats =:= [] ->
%                 Pid ! {Ref, make_cat(Name, Color, Description)},
%                 loop(Cats);
%                 Cats =/= [] ->
%                     Pid ! {Ref, hd(Cats)},
%                     loop(tl(Cats))
%             end;
%         {return, Cat = #cat{}} ->
%             loop([Cat|Cats]);
%         {Pid, Ref, terminate} ->
%             Pid ! {Ref, ok},
%             terminate(Cats);
%         Unknown ->
%             io:format("Неизвестное сообщение ~p~n", [Unknown]),
%             loop(Cats)
%     end.