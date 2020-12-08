-module(dependency).
-export([new_dependency/2,print_dependency/1]).
-import(maps, [get/2]).

new_dependency(Count, Color) ->
    #{count => Count, color => Color}.

print_dependency(Dependency) ->
    Cnt = maps:get(count, Dependency),
    Clr = maps:get(color, Dependency),
    io:fwrite("Count: ~w; Color: ~p", [Cnt, Clr]).
