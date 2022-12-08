defmodule Common do
  # Are the first m elements of s distinct?
  def distinct(s, m) do
    m ==
      s
      |> String.slice(0..(m - 1))
      |> String.graphemes()
      |> MapSet.new()
      |> MapSet.size()
  end

  def foo(s, m, n) do
    if distinct(s, m) do
      n
    else
      foo(String.slice(s, 1..-1//1), m, n + 1)
    end
  end

  # First index in file where the last n elements are distinct
  def answer(file, n) do
    file
    |> File.read!()
    |> Common.foo(n, n)
  end
end

defmodule PartOne do
  def answer(file) do
    Common.answer(file, 4)
    |> IO.inspect()
  end
end

defmodule PartTwo do
  def answer(file) do
    Common.answer(file, 14)
    |> IO.inspect()
  end
end

PartOne.answer("sample1")
PartOne.answer("sample2")
PartOne.answer("sample3")
PartOne.answer("sample4")
PartOne.answer("sample5")
PartOne.answer("input")

PartTwo.answer("sample1")
PartTwo.answer("sample2")
PartTwo.answer("sample3")
PartTwo.answer("sample4")
PartTwo.answer("sample5")
PartTwo.answer("input")
