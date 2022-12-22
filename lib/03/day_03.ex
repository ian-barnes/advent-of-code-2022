defmodule AdventOfCode2022.Day03 do
  defmodule Common do
    def read_lines(name) do
      name
      |> File.read!()
      |> String.split("\n")
      |> Enum.filter(fn s -> String.length(s) > 0 end)
    end

    def str_to_set(s) do
      s |> String.to_charlist() |> MapSet.new()
    end

    defguard is_uppercase(c) when c >= 65 and c <= 90
    defguard is_lowercase(c) when c >= 97 and c <= 122

    def score(c) when is_uppercase(c) do
      c - 64 + 26
    end

    def score(c) when is_lowercase(c) do
      c - 96
    end
  end

  defmodule PartOne do
    defp split(s) do
      String.split_at(s, div(String.length(s), 2))
    end

    defp intersection(s) do
      {left, right} = split(s)

      MapSet.intersection(Common.str_to_set(left), Common.str_to_set(right))
      |> MapSet.to_list()
      |> hd()
    end

    def answer(file) do
      file
      |> Common.read_lines()
      |> Enum.map(&intersection/1)
      |> Enum.map(&Common.score/1)
      |> Enum.sum()
    end
  end

  defmodule PartTwo do
    defp handle_one(item, acc) do
      if Enum.count(hd(acc)) == 3 do
        [[item]] ++ acc
      else
        [[item] ++ hd(acc)] ++ tl(acc)
      end
    end

    defp group_in_3s(items) do
      List.foldl(items, [[]], &handle_one/2)
    end

    defp intersection(strings) do
      sets = Enum.map(strings, &Common.str_to_set/1)

      List.foldl(tl(sets), hd(sets), fn set, acc -> MapSet.intersection(set, acc) end)
      |> MapSet.to_list()
      |> hd()
    end

    def answer(file) do
      file
      |> Common.read_lines()
      |> group_in_3s()
      |> Enum.map(&intersection/1)
      |> Enum.map(&Common.score/1)
      |> Enum.sum()
    end
  end
end
