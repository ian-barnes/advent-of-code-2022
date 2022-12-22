defmodule Day07Test do
  defmodule PartOneTest do
    use ExUnit.Case
    import AdventOfCode2022.Day07.PartOne

    test "day 7 part 1 sample" do
      assert answer("test/07/sample") == 95437
    end

    test "day 7 part 1 actual" do
      assert answer("test/07/input") == 1_307_902
    end
  end

  defmodule PartTwoTest do
    use ExUnit.Case
    import AdventOfCode2022.Day07.PartTwo

    test "day 7 part 2 sample" do
      assert answer("test/07/sample") == 24_933_642
    end

    test "day 7 part 2 actual" do
      assert answer("test/07/input") == 7_068_748
    end
  end
end
