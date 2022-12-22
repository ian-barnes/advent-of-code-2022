defmodule AdventOfCode2022.Day07 do
  # Advent of code 2022, Day 7

  defmodule Util do
    # Tail of a list, but...
    def safe_tail([_head | tail]) do
      tail
    end

    # ... don't crash if it's empty
    def safe_tail([]) do
      nil
    end
  end

  # Two named struct types to represent files and directories. Paths are stored as
  # linked lists in reverse order, so to go down you add a new thing at the head,
  # and to go back up one level you just take the tail of the list.

  defmodule File_node do
    defstruct [:path, :size]

    def new(path, size) do
      %File_node{path: path, size: size}
    end
  end

  defmodule Dir_node do
    defstruct [:path]

    def new(path) do
      %Dir_node{path: path}
    end
  end

  # Protocols (polymorphic functions) to get the parent directory and the size of
  # any node. In the end I think this could have been done more simply without
  # using the protocol construct, just something like
  #
  # `def size(thing) when is_struct(thing, File_node), do ...`
  #
  # and similarly for `Dir_node`.

  defprotocol Parent do
    @spec parent(t) :: String.t()
    def parent(value)
  end

  defimpl Parent, for: File_node do
    def parent(%File_node{path: path, size: _}) do
      Util.safe_tail(path)
    end
  end

  defimpl Parent, for: Dir_node do
    def parent(%Dir_node{path: path}) do
      Util.safe_tail(path)
    end
  end

  defprotocol Size do
    @spec size(t, List) :: Integer
    def size(value, context)
  end

  defimpl Size, for: File_node do
    def size(%File_node{path: _, size: size}, _) do
      size |> String.to_integer()
    end
  end

  # To get the size of a directory, find all nodes with that directory as parent,
  # compute their sizes, and take the sum. To get the size of a subdirectory is a
  # recursive call. Of course there are more efficient ways to do this...
  defimpl Size, for: Dir_node do
    def size(%Dir_node{path: path}, context) do
      context
      |> Enum.filter(fn thing -> Parent.parent(thing) == path end)
      |> Enum.map(fn thing -> Size.size(thing, context) end)
      |> Enum.sum()
    end
  end

  defmodule Common do
    def read_lines(name) do
      name
      |> File.read!()
      |> String.split("\n")
      |> Enum.filter(fn s -> String.length(s) > 0 end)
      |> Enum.map(&String.split/1)
    end

    # State is an enum consisting of a list of nodes with full paths, plus the
    # current path. Commands change the state: `cd` changes the current path but
    # leaves the node list unchanged, `ls` itself does nothing, but each of its
    # lines of output adds a new node to the list. At the end we throw away the
    # current path and keep the list of nodes.

    def start do
      {[Dir_node.new([])], nil}
    end

    def cd({things, current}, name) do
      cond do
        name == "/" -> {things, []}
        name == ".." -> {things, Util.safe_tail(current)}
        true -> {things, [name | current]}
      end
    end

    def add_file({things, current}, name, size) do
      {[File_node.new([name | current], size) | things], current}
    end

    def add_dir({things, current}, name) do
      {[Dir_node.new([name | current]) | things], current}
    end

    def handle_line(cmd, state) do
      [first | [second | rest]] = cmd

      cond do
        first == "$" and second == "cd" ->
          [third | _] = rest
          cd(state, third)

        first == "$" ->
          state

        first == "dir" ->
          add_dir(state, second)

        true ->
          add_file(state, second, first)
      end
    end

    def build_node_list(filename) do
      Common.read_lines(filename)
      |> List.foldl(
        Common.start(),
        fn cmd, state -> Common.handle_line(cmd, state) end
      )
      |> elem(0)
    end

    def compute_directory_sizes(objects) do
      objects
      |> Enum.filter(fn x -> is_struct(x, Dir_node) end)
      |> Enum.map(fn x -> Size.size(x, objects) end)
    end
  end

  defmodule PartOne do
    def answer(filename) do
      Common.build_node_list(filename)
      |> Common.compute_directory_sizes()
      |> Enum.filter(fn n -> n <= 100_000 end)
      |> Enum.sum()
    end
  end

  defmodule PartTwo do
    def answer(filename) do
      sizes_desc =
        Common.build_node_list(filename)
        |> Common.compute_directory_sizes()
        |> Enum.sort()
        |> Enum.reverse()

      [root | subdirs] = sizes_desc
      free = 70_000_000 - root
      required = 30_000_000 - free

      subdirs
      |> Enum.reverse()
      |> Enum.find(fn n -> n >= required end)
    end
  end
end
