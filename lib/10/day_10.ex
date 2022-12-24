defmodule AdventOfCode2022.Day10 do
  defmodule Common do
    defp add_wait(cmd) do
      if String.starts_with?(cmd, "addx ") do
        ["noop", cmd]
      else
        cmd
      end
    end

    def parse(file) do
      file
      |> File.read!()
      |> String.split("\n")
      |> Enum.filter(fn s -> String.length(s) > 0 end)
      |> Enum.map(&add_wait/1)
      |> List.flatten()
    end

    def update_pos(state, "noop"), do: %{state | t: state.t + 1}

    def update_pos(state, "addx " <> n) do
      %{state | t: state.t + 1, x: state.x + String.to_integer(n)}
    end
  end

  defmodule PartOne do
    defp update_score(state) do
      if rem(state.t, 40) == 20 do
        value = state.t * state.x
        %{state | score: state.score + value}
      else
        state
      end
    end

    defp handle_cmd(cmd, state) do
      state |> Common.update_pos(cmd) |> update_score()
    end

    def answer(file) do
      initial_state = %{x: 1, t: 1, score: 0}

      final_state =
        file
        |> Common.parse()
        |> List.foldl(initial_state, &handle_cmd/2)

      final_state.score
    end
  end

  defmodule PartTwo do
    defp update_buffer(state) do
      cycle = state.t
      pos = rem(cycle - 1, 40)
      sprite = state.x
      pixel = if abs(sprite - pos) <= 1, do: "#", else: "."
      %{state | buffer: state.buffer <> pixel}
    end

    defp break_lines(state) do
      if rem(state.t, 40) == 0 do
        %{state | buffer: state.buffer <> "\n"}
      else
        state
      end
    end

    defp handle_cmd(cmd, state) do
      state |> update_buffer() |> break_lines() |> Common.update_pos(cmd)
    end

    def answer(file) do
      initial_state = %{x: 1, t: 1, buffer: ""}

      final_state =
        file
        |> Common.parse()
        |> List.foldl(initial_state, &handle_cmd/2)

      final_state.buffer
    end
  end
end
