defmodule BitmaskCalculator do
  import ParallelTask
  import Bitwise
  defp _get_x_mask(["X"]),      do: "1"
  defp _get_x_mask(["X"|mask]), do: "1" <> _get_x_mask(mask)
  defp _get_x_mask([_]),        do: "0"
  defp _get_x_mask([_|mask]),   do: "0" <> _get_x_mask(mask)
  defp get_x_mask(mask) do
    # converts the mask, all non "x" is set to 0
    Integer.parse(_get_x_mask(mask|>String.codepoints), 2)
  end

  defp _get_true_mask(["1"]),      do: "1"
  defp _get_true_mask(["1"|mask]), do: "1" <> _get_true_mask(mask)
  defp _get_true_mask([_]),        do: "0"
  defp _get_true_mask([_|mask]),   do: "0" <> _get_true_mask(mask)
  defp get_true_mask(mask) do
    # converts the mask, all non 1 is set to 0
    Integer.parse(_get_true_mask(mask|>String.codepoints), 2)
  end

  defp calculate(mask, value) do
    {x_mask, _} = get_x_mask(mask)
    {true_mask, _} = get_true_mask(mask)
    (value &&& x_mask) ||| true_mask
  end

  defp single_proc([mask|[mem]]) do
    %{mem.mem => calculate(mask.mask, mem.val)}
  end
  defp single_proc([mask|mems]) do
    [mem|tail] = Enum.reverse(mems)
    map = single_proc([mask|tail])
    Map.merge(map, %{mem.mem => calculate(mask.mask, mem.val)})
    # für alle weiteren überschreiben
  end

  defp _sum([{_,value}]) do
    value
  end
  defp _sum([{_,value}|results]) do
    _sum(results) + value
  end
  defp sum(results) do
    Map.to_list(results) |> _sum
  end

  defp _process([group]) do
    single_proc(group)
  end
  defp _process([group|groups]) do
    later_result = _process(groups)
    result = single_proc(group)
    Map.merge(result, later_result)
  end
  def process(groups) do
    results = _process(groups)
    sum(results)
  end
end

defmodule Day14 do
  def part1(filename) do
    IO.puts "Part 1"
    groups = Parser.read_file(filename) # automatically includes Parser
    BitmaskCalculator.process(groups)
  end
  def main do
    part1("input.txt")
  end
end

Day14.main()

defmodule BitmaskCalculatorV2 do
  import ParallelTask
  defp single_proc([mask|mems]) do
    IO.puts(mask[:mask])
    mem_sum = 0
    for mem <- mems, do: IO.inspect(Integer.to_string(mem[:val], 2))
  end
  defp _process([], _) do
    ParallelTask.new
  end
  defp _process([group|groups], i) do
    _process(groups, i+1) |> ParallelTask.add(i, fn -> single_proc(group) end)
  end
  def process(groups) do
    IO.inspect(_process(groups, 0) |> ParallelTask.perform)
  end
end

