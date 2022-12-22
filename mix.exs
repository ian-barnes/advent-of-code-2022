defmodule AdventOfCode2022.MixProject do
  use Mix.Project

  def project do
    [
      app: :advent_of_code_2022,
      version: "0.1.0",
      elixir: "~> 1.14",
      deps: deps(),
      default_task: "test"
    ]
  end

  defp deps(), do: []
end
