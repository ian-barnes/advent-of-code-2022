defmodule Common do
  defp read_lines(name) do
    name
    |> File.read!()
    |> String.split("\n")
  end

  defp to_list_rec("", acc) do acc end
  defp to_list_rec(s, acc) do
    {head, tail} = String.split_at(s, 4)
    to_list_rec(tail, acc ++ [head])
  end

  defp to_list(s) do
    to_list_rec(s, [])
  end

  defp extract_item(s) do
    case Regex.run(~r/[[:alpha:]]/, s) do
      nil -> nil
      [s] -> s
    end
  end

  defp extract_items(strings) do
    Enum.map(strings, &extract_item/1)
  end

  defp add_row(nil, stack) do stack end
  defp add_row(item, stack) do
    stack ++ [item]
  end

  defp add_row_to_piles(row, stacks) do
    Enum.zip_with(row, stacks, &add_row/2)
  end

  defp build_piles(lines) do
    items =
      lines
      |> Enum.take_while(fn line -> String.length(line) > 0 end)
      |> Enum.drop(-1)
      |> Enum.map(&to_list/1)
      |> Enum.map(&extract_items/1)
    empty_piles = List.duplicate([], Enum.count(hd(items)))
    List.foldl(items, empty_piles, &add_row_to_piles/2)
  end

  defp parse_one(s) do
    Regex.run(
      ~r/move ([[:digit:]]+) from ([[:digit:]]+) to ([[:digit:]]+)/,
      s,
      capture: :all_but_first
    )
    |> Enum.map(&String.to_integer/1)
  end

  defp parse_instructions(lines) do
    lines
    |> Enum.drop_while(fn line -> String.length(line) > 0 end)
    |> Enum.filter(fn s -> String.length(s) > 0 end)
    |> Enum.map(&parse_one/1)
  end

  def parse(file) do
    lines = file |> read_lines()
    piles = lines |> build_piles()
    instructions = lines |> parse_instructions()
    {piles, instructions}
  end

  def get_answer(piles) do
    piles
    |> Enum.map(fn items -> hd(items) end)
    |> Enum.join()
    |> IO.inspect()
  end
end

defmodule PartOne do
  defp pop(1, piles) do
    {hd(hd(piles)), [tl(hd(piles))] ++ tl(piles)}
  end
  defp pop(from, piles) do
    {thing, tail} = pop(from - 1, tl(piles))
    {thing, [hd(piles)] ++ tail}
  end

  defp push(thing, 1, piles) do
    [[thing] ++ hd(piles)] ++ tl(piles)
  end
  defp push(thing, to, piles) do
    [hd(piles)] ++ push(thing, to - 1, tl(piles))
  end

  defp move_one(from, to, piles) do
    {item, popped} = pop(from, piles)
    push(item, to, popped)
  end

  defp execute_one([0, _, _], piles) do piles end
  defp execute_one([count, from, to], piles) do
    execute_one([count - 1, from, to], move_one(from, to, piles))
  end

  defp execute({piles, []}) do piles end
  defp execute({piles, instructions}) do
    execute({execute_one(hd(instructions), piles), tl(instructions)})
  end

  def answer(file) do
    file |> Common.parse() |> execute() |> Common.get_answer()
  end
end

defmodule PartTwo do
  defp drop(things, 1, piles) do
    [things ++ hd(piles)] ++ tl(piles)
  end
  defp drop(things, to, piles) do
    [hd(piles)] ++ drop(things, to - 1, tl(piles))
  end

  defp lift(count, 1, piles) do
    {Enum.take(hd(piles), count), [Enum.drop(hd(piles), count)] ++ tl(piles)}
  end
  defp lift(count, from, piles) do
    {lifted, tail} = lift(count, from - 1, tl(piles))
    {lifted, [hd(piles)] ++ tail}
  end

  defp execute_one([count, from, to], piles) do
    {lifted, remaining} = lift(count, from, piles)
    drop(lifted, to, remaining)
  end

  defp execute({piles, []}) do piles end
  defp execute({piles, instructions}) do
    execute({execute_one(hd(instructions), piles), tl(instructions)})
  end

  def answer(file) do
    file |> Common.parse() |> execute() |> Common.get_answer()
  end
end

PartOne.answer("sample")
PartOne.answer("input")
PartTwo.answer("sample")
PartTwo.answer("input")
