defmodule AdventOfCode2022.Day08 do
  defmodule Common do
    def read_rows(file) do
      file
      |> File.read!()
      |> String.split("\n")
      |> Enum.filter(fn s -> String.length(s) > 0 end)
      |> Enum.map(&String.codepoints/1)
    end

    def at(forest, i, j), do: forest |> Enum.at(i, []) |> Enum.at(j, -1)
    def above(forest, i, j), do: at(forest, i - 1, j)
    def below(forest, i, j), do: at(forest, i + 1, j)
    def left(forest, i, j), do: at(forest, i, j - 1)
    def right(forest, i, j), do: at(forest, i, j + 1)
    def size(forest), do: max(length(forest), length(hd(forest)))
  end

  defmodule PartOne do
    def visible_from_above(forest, i, j) do
      0..(i - 1)//1
      |> Enum.all?(fn k -> Common.at(forest, k, j) < Common.at(forest, i, j) end)
    end

    def visible_from_below(forest, i, j) do
      (i + 1)..Common.size(forest)//1
      |> Enum.all?(fn k -> Common.at(forest, k, j) < Common.at(forest, i, j) end)
    end

    def visible_from_left(forest, i, j) do
      0..(j - 1)//1
      |> Enum.all?(fn k -> Common.at(forest, i, k) < Common.at(forest, i, j) end)
    end

    def visible_from_right(forest, i, j) do
      (j + 1)..Common.size(forest)//1
      |> Enum.all?(fn k -> Common.at(forest, i, k) < Common.at(forest, i, j) end)
    end

    def answer(file) do
      forest = file |> Common.read_rows()
      size = forest |> Common.size()

      0..(size - 1)
      |> Enum.map(fn i -> 0..(size - 1) |> Enum.map(fn j -> {i, j} end) end)
      |> List.flatten()
      |> Enum.map(fn {i, j} ->
        visible_from_above(forest, i, j) or
          visible_from_below(forest, i, j) or
          visible_from_left(forest, i, j) or
          visible_from_right(forest, i, j)
      end)
      |> Enum.count(&Function.identity/1)
    end
  end

  defmodule PartTwo do
    defp take_until(xs, f) do
      List.foldl(
        xs,
        {[], false},
        fn x, {acc, done} ->
          cond do
            done -> {acc, true}
            f.(x) -> {[x | acc], true}
            true -> {[x | acc], false}
          end
        end
      )
      |> elem(0)
      |> Enum.reverse()
    end

    defp visible(heights, height) do
      heights |> take_until(fn x -> x >= height end) |> length()
    end

    def north(forest, i, j) do
      (i - 1)..0//-1
      |> Enum.map(fn k -> Common.at(forest, k, j) end)
      |> visible(Common.at(forest, i, j))
    end

    defp south(forest, i, j) do
      (i + 1)..(Common.size(forest) - 1)//1
      |> Enum.map(fn k -> Common.at(forest, k, j) end)
      |> visible(Common.at(forest, i, j))
    end

    defp east(forest, i, j) do
      (j + 1)..(Common.size(forest) - 1)//1
      |> Enum.map(fn k -> Common.at(forest, i, k) end)
      |> visible(Common.at(forest, i, j))
    end

    defp west(forest, i, j) do
      (j - 1)..0//-1
      |> Enum.map(fn k -> Common.at(forest, i, k) end)
      |> visible(Common.at(forest, i, j))
    end

    defp score(forest, i, j) do
      north(forest, i, j) * south(forest, i, j) * east(forest, i, j) * west(forest, i, j)
    end

    def answer(file) do
      forest = file |> Common.read_rows()
      size = forest |> Common.size()

      0..(size - 1)
      |> Enum.map(fn i -> 0..(size - 1) |> Enum.map(fn j -> {i, j} end) end)
      |> List.flatten()
      |> Enum.map(fn {i, j} -> score(forest, i, j) end)
      |> Enum.max()
    end
  end
end
