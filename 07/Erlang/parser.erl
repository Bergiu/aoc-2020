-module(parser).
-export([read_input/1]).
-import(lists, [append/2, nth/2, join/2, sublist/3, split/2]).
-import(string, [sub_string/3, str/2, len/1, tokens/2, concat/2, to_integer/1]).


%%%%%%% TYPES %%%%%%%
new_dependency(Count, Color) ->
    #{count => Count, color => Color}.

new_color(Color, Dependencies) ->
    {Color, Dependencies}.
%%%%%%%%%%%%%%%%%%%%%

%%%%%%% HELPER %%%%%%%
% concatenates a list of stings to one string
% ["hallo", "welt"] -> "hallowelt"
concat([]) ->
    "";
concat([Head | Tail]) ->
    string:concat(Head, concat(Tail)).

% concatenates a range in a list of strings into one string separated by space.
% ["hallo", "welt"] -> "hallo welt"
concat_list_range(List, From, Len) ->
    concat(lists:join(" ", lists:sublist(List, From, Len))).
%%%%%%%%%%%%%%%%%%%%%%

%%%%%%% PARSER %%%%%%%
% parses the dependency part of the input into a dependency object (map)
parse_dependency(Head) ->
    {Count, _Rest} = string:to_integer(lists:nth(1, Head)),
    Color = concat_list_range(Head, 2, 2),
    new_dependency(Count, Color).

% parses all dependencies of one line into a list of dependency objects.
% first overload handles the ["no", "other", "bags"] case.
parse_dependencies(["no" | _]) ->
    [];
parse_dependencies(Splitted) when length(Splitted) < 4 ->
    [];
parse_dependencies(Splitted) ->
    {Head, Tail} = lists:split(4, Splitted),
    append([parse_dependency(Head)], parse_dependencies(Tail)).

% parses one line of the input
parse_line(Line) ->
    Splitted = string:tokens(Line, " "),
    Color = concat_list_range(Splitted, 1, 2),
    {_, Tail} = lists:split(4, Splitted),
    Dependencies = parse_dependencies(Tail),
    new_color(Color, Dependencies).
%%%%%%%%%%%%%%%%%%%%%%

%%%%%%% HANDLE FILE %%%%%%%
% reads and parses all lines of the file
get_all_lines(Device) ->
    case io:get_line(Device, "") of
        eof -> [];
        Line -> append([parse_line(Line)], get_all_lines(Device))
    end.

% reads the file and outputs a list of colors
read_input(Filename) ->
    {ok, Device} = file:open(Filename, [read]),
    try get_all_lines(Device)
        after file:close(Device)
    end.
%%%%%%%%%%%%%%%%%%%%%%%%%%%
