defmodule AdventOfCode2022.Day04 do
  defmodule Common do
    defp read_lines(name) do
      name
      |> File.read!()
      |> String.split("\n")
      |> Enum.filter(fn s -> String.length(s) > 0 end)
    end

    defp string_to_set(s) do
      s
      |> String.split("-")
      |> Enum.map(&String.to_integer/1)
      |> List.to_tuple()
      |> Kernel.then(fn {first, last} -> Range.new(first, last) end)
      |> MapSet.new()
    end

    def to_sets(file) do
      file
      |> read_lines()
      |> Enum.map(fn s -> String.split(s, ",") end)
      |> Enum.map(fn strings -> Enum.map(strings, &string_to_set/1) end)
    end
  end

  defmodule PartOne do
    defp subset_symmetric?(sets) do
      {s1, s2} = {hd(sets), hd(tl(sets))}
      MapSet.subset?(s1, s2) or MapSet.subset?(s2, s1)
    end

    def answer(file) do
      file
      |> Common.to_sets()
      |> Enum.map(&subset_symmetric?/1)
      |> Enum.count(&Function.identity/1)
    end
  end

  defmodule PartTwo do
    defp overlapping?(sets) do
      {s1, s2} = {hd(sets), hd(tl(sets))}
      not MapSet.disjoint?(s1, s2)
    end

    def answer(file) do
      file
      |> Common.to_sets()
      |> Enum.map(&overlapping?/1)
      |> Enum.count(&Function.identity/1)
    end
  end
end
