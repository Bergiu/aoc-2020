-module(day7).
-export([part2/1,part2_test/1,part1/1,part1_test/1]).
-import(lists, [get/2]).
-import(color, [new_color/2]).
-import(dependency, [new_dependency/2]).
-import(parser, [read_input/1]).
-import(sets, [set/1, add_element/2, union/2, to_list/1]).


count_dependencies_inner(_, []) ->
    0;
count_dependencies_inner(Colors, Dependencies) ->
    [Head | Tail] = Dependencies,
    maps:get(count, Head) * count_dependencies_(Colors, maps:get(color, Head)) + 
    count_dependencies_inner(Colors, Tail).


count_dependencies_(Colors, Bag) ->
    {Color, Deps} = lists:keyfind(Bag, 1, Colors),
    count_dependencies_inner(Colors, Deps) + 1.


count_dependencies(Colors, Bag) ->
    count_dependencies_(Colors, Bag) - 1.



find_possible_parents_from_dep(Dependency, Bag, ColorBag, ColorName) ->
    Color = maps:get(color, Dependency),
    if Color == Bag ->
           io:fwrite(Color),
           add_element(ColorName, find_possible_parents_from_colors(ColorBag, ColorName, ColorBag));
       true ->
           sets:new()
    end.

find_possible_parents_from_color(ColorName, [], Bag, ColorBag) ->
    sets:new();
find_possible_parents_from_color(ColorName, Dependencies, Bag, ColorBag) ->
    [Dependency | Tail] = Dependencies,
    union(
      find_possible_parents_from_dep(Dependency, Bag, ColorBag, ColorName),
      find_possible_parents_from_color(ColorName, Tail, Bag, ColorBag)
     ).

find_possible_parents_from_colors([], Bag, ColorBag) ->
    sets:new();
find_possible_parents_from_colors(Colors, Bag, ColorBag) ->
    [Color | Tail] = Colors,
    {ColorName, Dependencies} = Color,
    union(
      find_possible_parents_from_color(ColorName, Dependencies, Bag, ColorBag),
      find_possible_parents_from_colors(Tail, Bag, ColorBag)
    ).

find_possible_parents_count(Colors, Bag) ->
    length(to_list(find_possible_parents_from_colors(Colors, Bag, Colors))).


part2_test(Filename) ->
    Colors = parser:read_input(Filename),
    Cnt = count_dependencies(Colors, "faded blue"),
    io:fwrite("Test Input should be 0: ~w~n", [Cnt]),
    Cnt2 = count_dependencies(Colors, "vibrant plum"),
    io:fwrite("Test Input should be 11: ~w~n", [Cnt2]),
    Cnt3 = count_dependencies(Colors, "shiny gold"),
    io:fwrite("Test Input should be 32: ~w~n", [Cnt3]).

part2(Filename) ->
    Colors = parser:read_input(Filename),
    Cnt3 = count_dependencies(Colors, "shiny gold"),
    io:fwrite("Part2: ~w~n", [Cnt3]).

part1_test(Filename) ->
    Colors = parser:read_input(Filename),
    Cnt = count_dependencies(Colors, "shiny gold"),
    io:fwrite("Test Input should be 4: ~w~n", [Cnt]).

part1(Filename) ->
    Colors = parser:read_input(Filename),
    Cnt = find_possible_parents_count(Colors, "shiny gold"),
    io:fwrite("Part1: ~w~n", [Cnt]).

main([String]) ->
    io:fwrite("Start"),
    part2(String);
main(_) ->
    io:fwrite("Start"),
    part2("input.txt").
