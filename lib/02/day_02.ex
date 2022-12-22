defmodule AdventOfCode2022.Day02 do
  defmodule Common do
    def pairs(file) do
      map = %{
        "A" => 1,
        "B" => 2,
        "C" => 3,
        "X" => 1,
        "Y" => 2,
        "Z" => 3
      }

      file
      |> File.read!()
      |> String.split("\n")
      |> Enum.filter(fn s -> String.length(s) > 0 end)
      |> Enum.map(fn s -> String.split(s, " ") end)
      |> Enum.map(fn [left, right] -> {map[left], map[right]} end)
    end

    def score(tuple) do
      {a, b} = tuple
      b + 3 * rem(b - a + 4, 3)
    end
  end

  # Part One
  defmodule PartOne do
    def answer(file) do
      file
      |> Common.pairs()
      |> Enum.map(&Common.score/1)
      |> Enum.sum()
    end
  end

  defmodule PartTwo do
    def choice(a, b) do
      rem(rem(a + b + 1, 3) - 3, 3) + 3
    end

    def answer(file) do
      file
      |> Common.pairs()
      |> Enum.map(fn {a, b} -> {a, choice(a, b)} end)
      |> Enum.map(&Common.score/1)
      |> Enum.sum()
    end
  end
end
