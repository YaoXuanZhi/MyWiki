-module(test).
-export([start/0]).

-record(st_boss_icon, {
         monsterId = 0,
         killedTimes = 0,
         iconState = 0
         }).

% 记录列表转换成双层列表
start1() ->
    % 记录列表
    RecordList = [#st_boss_icon{monsterId = X} || X <- [1001, 1002, 1003, 1004, 1005]],

    % 双层列表
    DoubleList = [[A, B, C] || #st_boss_icon{monsterId = A, 
                                            killedTimes = B,
                                            iconState = C} <- RecordList],
    io:fwrite("start1 ==> ~p ~n ~p ~n", [RecordList, DoubleList]).

start2() ->
    % 记录列表
    RecordList = [#st_boss_icon{monsterId = X} || X <- [1001, 1002, 1003, 1004, 1005]],

    % 元组列表
    TupleList = [{A, B, C} || #st_boss_icon{monsterId = A, 
                                            killedTimes = B,
                                            iconState = C} <- RecordList],
    io:fwrite("start2 ==> ~p ~n ~p ~n", [RecordList, TupleList]).

start3() ->
    % 双层列表
    DoubleList = [[X, 0, 0 ] || X <- [1001, 1002, 1003, 1004, 1005]],

    % 元组列表
    TupleList = [{A, B, C} || [A, B, C] <- DoubleList],
    io:fwrite("start3 ==> ~p ~n ~p ~n", [DoubleList, TupleList]).

start4() ->
    % 双层列表
    DoubleList = [[X, 0, 0 ] || X <- [1001, 1002, 1003, 1004, 1005]],

    % 记录列表
    RecordList = [#st_boss_icon{monsterId = A, killedTimes = B, iconState = C}
                                            || [A, B, C] <- DoubleList],
    io:fwrite("start4 ==> ~p ~n ~p ~n", [DoubleList, RecordList]).

start5() ->
    % 元组列表
    TupleList = [{X, 0, 0 } || X <- [1001, 1002, 1003, 1004, 1005]],

    % 记录列表
    RecordList = [#st_boss_icon{monsterId = A, killedTimes = B, iconState = C}
                                            || {A, B, C} <- TupleList],
    io:fwrite("start5 ==> ~p ~n ~p ~n", [TupleList, RecordList]).

start6() ->
    % 元组列表
    TupleList = [{X, 0, 0 } || X <- [1001, 1002, 1003, 1004, 1005]],

    % 双层列表
    DoubleList = [[A, B, C] || {A, B, C} <- TupleList],
    io:fwrite("start6 ==> ~p ~n ~p ~n", [TupleList, DoubleList]).

start7(BossId, KilledTimes) ->
    % 元组列表
    TupleList = [{X, 0, 0 } || X <- [1001, 1002, 1003, 1004, 1005]],
    F = fun(Tuple) ->
        {MonsterId, _, IconState} = Tuple,
        case MonsterId =:= BossId of
            true -> {BossId, KilledTimes, IconState};
            false -> Tuple
        end 
    end,
    NewList = lists:map(F, TupleList),
    io:fwrite("start7 ==> ~p ~n ~p ~n", [TupleList, NewList]).

start8(BossId, KilledTimes) ->
    % 双层列表
    DoubleList = [[X, 0, 0 ] || X <- [1001, 1002, 1003, 1004, 1005]],
    F = fun(List) ->
        [MonsterId, _, IconState] = List,
        case MonsterId =:= BossId of
            true -> [BossId, KilledTimes, IconState];
            false -> List
        end 
    end,
    NewList = lists:map(F, DoubleList),
    io:fwrite("start8 ==> ~p ~n ~p ~n", [DoubleList, NewList]).

start9(BossId, KilledTimes) ->
    % 记录列表
    RecordList = [#st_boss_icon{monsterId = X} || X <- [1001, 1002, 1003, 1004, 1005]],
    F = fun(Record) ->
        % #st_boss_icon{monsterId = MonsterId} = Record,
        MonsterId = Record#st_boss_icon.monsterId,
        case MonsterId =:= BossId of
            true -> Record#st_boss_icon{ killedTimes = KilledTimes};
            false -> Record
        end 
    end,
    NewList = lists:map(F, RecordList),
    io:fwrite("start9 ==> ~p ~n ~p ~n", [RecordList, NewList]).

% 双层列表根据记录列表来修改数值
start10(DoubleList) ->
    % 记录列表
    RecordList = [
        #st_boss_icon{monsterId = 1001, killedTimes = 1, iconState = 2}, 
        #st_boss_icon{monsterId = 1002, killedTimes = 4, iconState = 0}, 
        #st_boss_icon{monsterId = 1005, killedTimes = 5, iconState = 1} 
    ],

    F = fun(List) ->
        [MonsterId, _, _] = List,
                % lists:keyfind适用于元组列表和记录列表，因为记录列表是一种特殊的元组，#st_boss_icon{} 输出为 {st_boss_icon,0,0,0}
                % 是故记录里面，元素有这么一种隐藏关系:index = position + 1，
                case lists:keyfind(MonsterId, #st_boss_icon.monsterId, RecordList) of
                    false -> List;
                    Record ->
                        #st_boss_icon{killedTimes = KilledTimes, iconState = IconState} = Record,
                        [MonsterId, KilledTimes, IconState]
                end
    end,
    NewList = lists:map(F, DoubleList),
    io:fwrite("start10 ==> ~p ~n ~p ~n", [DoubleList, NewList]).

start11(DoubleList) ->
    RefrenceList = [
        {1001, 1, 2}, 
        {1002, 4, 0}, 
        {1005, 5, 1} 
    ],

    F = fun(List) ->
        [MonsterId, _, _] = List,
        % 在普通元组中，是没有st_boss_icon元素的，因此需要-1
        case lists:keyfind(MonsterId, #st_boss_icon.monsterId - 1, RefrenceList) of
            false -> List;
            L ->
                {_, KilledTimes, IconState} = L,
                [MonsterId, KilledTimes, IconState]
        end
    end,
    NewList = lists:map(F, DoubleList),
    io:fwrite("start11 ==> ~p ~n ~p ~n", [DoubleList, NewList]).

match(List, BossId) ->
    [MonsterId, _, _] = List,
    BossId =:= MonsterId.

start12(DoubleList) ->
    RefrenceList = [
        [1001, 1, 2], 
        [1002, 4, 0], 
        [1005, 5, 1] 
    ],

    F = fun(List) ->
        [MonsterId, _, _] = List,
        case [X || X <- RefrenceList, match(X, MonsterId)] of
            [] -> List;
            [H|_] ->
                [_, KilledTimes, IconState] = H, 
                [MonsterId, KilledTimes, IconState]
        end
    end,
    NewList = lists:map(F, DoubleList),
    io:fwrite("start12 ==> ~p ~n ~p ~n", [DoubleList, NewList]).

start13(BossId, KilledTimes) ->
    RecordList = [#st_boss_icon{monsterId = X} || X <- [1001, 1002, 1003, 1004, 1005]],
    L = case lists:keytake(BossId, #st_boss_icon.monsterId, RecordList) of
        false -> [#st_boss_icon{monsterId = BossId, killedTimes = KilledTimes}|RecordList];
        {_, H, T} -> 
            [H#st_boss_icon{killedTimes = KilledTimes}|T]
    end,
    io:fwrite("start13 ==> ~p ~n ", [L]).


start14() ->
    BossIds = [1001, 1002, 1003, 1004, 1005],
    RecordList = [
        #st_boss_icon{monsterId = 1001, killedTimes = 2, iconState = 2}, 
        #st_boss_icon{monsterId = 1005, killedTimes = 4, iconState = 1}
    ],
    L = lists:map(fun(Id) -> 
        case lists:keyfind(Id, #st_boss_icon.monsterId, RecordList) of
            false -> [Id, 0 ,0];
            H -> 
                [Id, H#st_boss_icon.killedTimes, H#st_boss_icon.iconState]
        end
        end, BossIds),
    io:fwrite("start14 ==> ~p~n", [L]).

start() ->
    io:fwrite("run begin~n"),
    start1(),
    start2(),
    start3(),
    start4(),
    start5(),
    start6(),
    start7(1003, 7),
    start8(1004, 7),
    start9(1001, 7),
    DoubleList = [[X, 0, 0] || X <- [1001, 1002, 1003, 1004, 1005]],
    start10(DoubleList),
    start11(DoubleList),
    start12(DoubleList),
    start13(1003, 5),
    start13(1010, 5),
    start14(),
    io:fwrite("~p ~p ~n", [#st_boss_icon{}, #st_boss_icon.monsterId]),
    io:fwrite("run end~n").
