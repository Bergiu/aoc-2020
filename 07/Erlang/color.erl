-module(color).
-export([new_color/2]).

new_color(Color, Dependencies) ->
    {Color, Dependencies}.
