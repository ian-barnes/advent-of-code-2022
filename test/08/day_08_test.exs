defmodule Day08Test do
  defmodule PartOne do
    use ExUnit.Case
    import AdventOfCode2022.Day08.PartOne

    test "day 8 part 1 sample" do
      assert answer("test/08/sample") == 21
    end

    test "day 8 part 1 actual" do
      assert answer("test/08/input") == 1543
    end
  end

  defmodule PartTwo do
    use ExUnit.Case
    import AdventOfCode2022.Day08.PartTwo

    test "day 8 part 2 sample" do
      assert answer("test/08/sample") == 8
    end

    test "day 8 part 2 actual" do
      assert answer("test/08/input") == 595_080
    end
  end
end
