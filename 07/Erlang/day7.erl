-module(day7).
-export([part2/1,part1/1]).
-import(lists, [get/2]).
-import(parser, [read_input/1]).
-import(sets, [set/1, add_element/2, union/2, to_list/1]).


part2(Filename) ->
    Colors = parser:read_input(Filename),
    Cnt3 = count_dependencies(Colors, "shiny gold"),
    io:fwrite("Part2: ~w~n", [Cnt3]).

part1(Filename) ->
    Colors = parser:read_input(Filename),
    Cnt = find_possible_parents_count(Colors, "shiny gold"),
    io:fwrite("Part1: ~w~n", [Cnt]).

main([String]) ->
    io:fwrite("Start"),
    part1(String),
    part2(String);
main(_) ->
    io:fwrite("Start"),
    part1("input.txt"),
    part2("input.txt").


%%%%%% PART 2 %%%%%%
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
%%%%%%%%%%%%%%%%%%%%


%%%%%% PART 1 %%%%%%
find_possible_parents_from_dep(Dependency, Bag, ColorBag, ColorName) ->
    Color = maps:get(color, Dependency),
    if Color == Bag ->
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
find_possible_parents_from_colors([{ColorName, Dependencies} | Tail], Bag, ColorBag) ->
    union(
      find_possible_parents_from_color(ColorName, Dependencies, Bag, ColorBag),
      find_possible_parents_from_colors(Tail, Bag, ColorBag)
    ).

find_possible_parents_count(Colors, Bag) ->
    length(to_list(find_possible_parents_from_colors(Colors, Bag, Colors))).
%%%%%%%%%%%%%%%%%%%%


