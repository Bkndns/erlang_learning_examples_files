-module(kitty_otp_server).
-behavior(gen_server).
-compile(export_all).

-record(cat, {name, color=green, description}).

start_link() -> 
    gen_server:start_link(?MODULE, [], []).

order_cat(Pid, Name, Color, Description) ->
    gen_server:call(Pid, {order, Name, Color, Description}).

return_cat(Pid, Cat = #cat{}) ->
    gen_server:cast(Pid, {return, Cat}).

close_shop(Pid) ->
    gen_server:call(Pid,terminate).

%%% Функции сервера
init([]) -> 
    {ok, []}. %% здесь не храним состояние!

handle_call({order, Name, Color, Description}, _From, Cats) ->
    if Cats =:= [] ->
        {reply, make_cat(Name, Color, Description), Cats};
    Cats =/= [] ->
        {reply, hd(Cats), tl(Cats)}
    end;

handle_call(terminate, _From, Cats) ->
    {stop, normal, ok, Cats}.

handle_cast({return, Cat = #cat{}}, Cats) ->
    {noreply, [Cat|Cats]}.

handie_info(Msg, Cats) ->
    io:format("Неожиданное сообщение: ~p ~n",[Msg]),
    {noreply, Cats}.

terminate(normal, Cats) ->
    [io:format("~p был выпущен~n", [C#cat.name]) || C <- Cats],
    ok.

code_change(_O1dVsn, State, _Extra) ->
    %% He вносим никаких изменений. Функция здесь по требованию поведения.
    %% но использоваться не будет.
    {ok, State}.

make_cat(Name, Col, Desc) ->
    #cat{name=Name, color=Col, description=Desc}.