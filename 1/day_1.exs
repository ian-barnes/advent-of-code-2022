defmodule Common do
  defp handle_one_line(line, acc) do
    if line == "" do
      [[]] ++ acc
    else
      [[String.to_integer(line)] ++ hd(acc)] ++ tl(acc)
    end
  end

  defp gather(lines) do
    List.foldl(lines, [[]], &handle_one_line/2)
  end

  def calories(file) do
    file
    |> File.read!()
    |> String.split("\n")
    |> gather()
    |> Enum.map(&Enum.sum/1)

  end
end

defmodule PartOne do
  def answer(file) do
    file
    |> Common.calories()
    |> Enum.max()
|> IO.inspect()

  end
end

defmodule PartTwo do
  def answer(file) do
    file
    |> Common.calories()
    |> Enum.sort()
    |> Enum.take(-3)
    |> Enum.sum()
    |> IO.inspect()
  end
end

PartOne.answer("sample")
PartOne.answer("input")

PartTwo.answer("sample")
PartTwo.answer("input")
