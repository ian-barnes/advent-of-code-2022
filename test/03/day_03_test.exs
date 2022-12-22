defmodule Day03Test do
  defmodule PartOne do
    use ExUnit.Case
    import AdventOfCode2022.Day03.PartOne

    test "day 3 part 1 sample" do
      assert answer("test/03/sample") == 157
    end

    test "day 3 part 1 actual" do
      assert answer("test/03/input") == 7701
    end
  end

  defmodule PartTwo do
    use ExUnit.Case
    import AdventOfCode2022.Day03.PartTwo

    test "day 3 part 2 sample" do
      assert answer("test/03/sample") == 70
    end

    test "day 3 part 2 actual" do
      assert answer("test/03/input") == 2644
    end
  end
end
