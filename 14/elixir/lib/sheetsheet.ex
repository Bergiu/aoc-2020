# ternary operator:
# if age > 18, do: "Can Vote", else: "cant vote"

# my_stats = {1, 6, :TheVillage}
# macht ein tuple

# elem(my_stats, 2)

# index beginnt bei 0

# [1,2,3]
# lists

# l1 ++ l2 
# l1 -- l2
# "a" in l1
# [head|tail] = l1

# IO.puts ist print

# IO.inspect ist glaub ich ein print dass objekte ausgibt

# IO.inspect [1,2], char_lists: :as_lists

# sonst wird das als chars ausgegeben

# Enum.each tail, fn item ->
#   IO.puts item
# end

# def display_list([word|words]) do
#   IO.puts words
#   display_list(words)
# end
# def display_list ([]),  do: nil

# c(datei)

# kompiliert die datei wie in erlang

# %{"key" => "value"}

# var["key"]

# %{key: "value"}
# var.key

# Dict.put_new(var, "a", "b")


# # pattern matching

# [length, width] = [20, 30]
# [_, [_, a]] = [20, [30, 40]]

# # anonymous function

# get_sum = fn (x,y) -> x + y end
# IO.puts get_sum(5,5)

# IO.puts ?a
# # gibt den code point von a zurück
# IO.puts 0x0061
# IO.puts "\u0061"
# IO.puts :binary.decode_unsigned <<0::1, 0::1, 1::1, 0::1, 1::1, 0::1, 1::1, 0::1>>
#
#
# def a(b \\ 1) default value
