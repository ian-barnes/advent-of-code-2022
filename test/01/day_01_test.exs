defmodule Day01Test do
  defmodule PartOne do
    use ExUnit.Case
    import AdventOfCode2022.Day01.PartOne

    test "day 1 part 1 sample" do
      assert answer("test/01/sample") == 24000
    end

    test "day 1 part 1 actual" do
      assert answer("test/01/input") == 72070
    end
  end

  defmodule PartTwo do
    use ExUnit.Case
    import AdventOfCode2022.Day01.PartTwo

    test "day 1 part 2 sample" do
      assert answer("test/01/sample") == 45000
    end

    test "day 1 part 2 actual" do
      assert answer("test/01/input") == 211_805
    end
  end
end
