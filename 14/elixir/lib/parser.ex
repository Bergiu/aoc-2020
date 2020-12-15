defmodule Parser do
  defp append_to_last([], append) do
    [[append]]
  end
  defp append_to_last([head], append) do
    [head ++ [append]]
  end
  defp append_to_last([head|tail], append) do
    [head|append_to_last(tail, append)]
  end
  defp _group_instructions([]) do
    []
  end
  defp _group_instructions([instruction | instructions]) do
    case instruction[:type] do
      :mem -> append_to_last(_group_instructions(instructions), instruction)
      :mask -> append_to_last(_group_instructions(instructions), instruction) ++ [[]]
    end
  end
  defp group_instructions(instructions) do
    Enum.reverse(
      Enum.reject(
        Enum.map(_group_instructions(instructions),
          & Enum.reverse/1), # reverse inner lists
        & Enum.empty?/1 # remove empty list
      )
    ) # reverse lists
  end
  defp parse_line(""), do: nil
  defp parse_line(line) do
    [left, right] = Enum.reject(
      Enum.map(
        String.split(line, "="), # split by =
        & String.trim(&1)), # remove trailing spaces
      & is_nil/1) # reject all that are nil (last line)
    cond do
      String.starts_with?(left, "mem") ->
        %{type: :mem,
          mem: Integer.parse(String.slice(left, 4, String.length(left) - 5))|> Tuple.to_list |> List.first,
          val: Integer.parse(right) |> Tuple.to_list |> List.first
        }
      String.starts_with?(left, "mask") ->
        %{type: :mask, mask: right}
      true -> raise "invalid input"
    end
  end

  def read_file(filename) do
    text = case File.read(filename) do
      {:ok, body} -> body
      {:error, reason} -> raise reason
    end
    instructions_nil = for line <- String.splitter(text, "\n"), do: parse_line(line)
    instructions = Enum.reject(instructions_nil, & is_nil/1)
    group_instructions(instructions)
  end
end
