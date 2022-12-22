defmodule Day02Test do
  defmodule PartOne do
    use ExUnit.Case
    import AdventOfCode2022.Day02.PartOne

    test "day 2 part 1 sample" do
      assert answer("test/02/sample") == 15
    end

    test "day 2 part 1 actual" do
      assert answer("test/02/input") == 14297
    end
  end

  defmodule PartTwo do
    use ExUnit.Case
    import AdventOfCode2022.Day02.PartTwo

    test "day 2 part 2 sample" do
      assert answer("test/02/sample") == 12
    end

    test "day 2 part 2 actual" do
      assert answer("test/02/input") == 10498
    end
  end
end
