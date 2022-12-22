defmodule Day04Test do
  defmodule PartOne do
    use ExUnit.Case
    import AdventOfCode2022.Day04.PartOne

    test "day 4 part 1 sample" do
      assert answer("test/04/sample") == 2
    end

    test "day 4 part 1 actual" do
      assert answer("test/04/input") == 582
    end
  end

  defmodule PartTwoTest do
    use ExUnit.Case
    import AdventOfCode2022.Day04.PartTwo

    test "day 4 part 2 sample" do
      assert answer("test/04/sample") == 4
    end

    test "day 4 part 2 actual" do
      assert answer("test/04/input") == 893
    end
  end
end
