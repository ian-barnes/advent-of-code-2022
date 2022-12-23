defmodule AdventOfCode2022.Day09 do
  defmodule Common do
    def parse(file) do
      file
      |> File.read!()
      |> String.split("\n")
      |> Enum.filter(fn s -> String.length(s) > 0 end)
      |> Enum.map(&String.split/1)
      |> Enum.map(&List.to_tuple/1)
      |> Enum.map(fn {dir, dist} -> {dir, String.to_integer(dist)} end)
      |> Enum.map(fn {d, n} -> List.duplicate(d, n) end)
      |> List.flatten()
    end

    def up({x, y}), do: {x, y + 1}
    def down({x, y}), do: {x, y - 1}
    def left({x, y}), do: {x - 1, y}
    def right({x, y}), do: {x + 1, y}

    def follow({hx, hy}, {tx, ty}) do
      {dx, dy} = {hx - tx, hy - ty}

      case {dx, dy} do
        {2, 0} -> {tx + 1, ty}
        {-2, 0} -> {tx - 1, ty}
        {0, 2} -> {tx, ty + 1}
        {0, -2} -> {tx, ty - 1}
        {2, 1} -> {tx + 1, ty + 1}
        {2, -1} -> {tx + 1, ty - 1}
        {-2, 1} -> {tx - 1, ty + 1}
        {-2, -1} -> {tx - 1, ty - 1}
        {1, 2} -> {tx + 1, ty + 1}
        {1, -2} -> {tx + 1, ty - 1}
        {-1, 2} -> {tx - 1, ty + 1}
        {-1, -2} -> {tx - 1, ty - 1}
        {2, 2} -> {tx + 1, ty + 1}
        {-2, 2} -> {tx - 1, ty + 1}
        {2, -2} -> {tx + 1, ty - 1}
        {-2, -2} -> {tx - 1, ty - 1}
        {_, _} -> {tx, ty}
      end
    end
  end

  defmodule PartOne do
    defp do_cmd(cmd, state) do
      {head, tail, visited} = state

      new_head =
        case cmd do
          "U" -> Common.up(head)
          "D" -> Common.down(head)
          "L" -> Common.left(head)
          "R" -> Common.right(head)
        end

      new_tail = Common.follow(new_head, tail)
      new_visited = MapSet.put(visited, new_tail)
      {new_head, new_tail, new_visited}
    end

    def answer(file) do
      state = {{0, 0}, {0, 0}, MapSet.new()}

      file
      |> Common.parse()
      |> List.foldl(state, &do_cmd/2)
      |> elem(2)
      |> MapSet.size()
    end
  end

  defmodule PartTwo do
    defp follow_all(head, tail) do
      tail
      |> List.foldl([head], fn knot, acc -> [Common.follow(hd(acc), knot) | acc] end)
      |> Enum.reverse()
    end

    defp do_cmd(cmd, state) do
      {[head | tail], visited} = state

      new_head =
        case cmd do
          "U" -> Common.up(head)
          "D" -> Common.down(head)
          "L" -> Common.left(head)
          "R" -> Common.right(head)
        end

      new_rope = follow_all(new_head, tail)
      last = new_rope |> Enum.reverse() |> hd()
      new_visited = MapSet.put(visited, last)
      {new_rope, new_visited}
    end

    def answer(file) do
      state = {List.duplicate({0, 0}, 10), MapSet.new()}

      file
      |> Common.parse()
      |> List.foldl(state, &do_cmd/2)
      |> elem(1)
      |> MapSet.size()
    end
  end
end
