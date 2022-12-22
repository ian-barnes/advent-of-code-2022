defmodule Day05Test do
  defmodule PartOne do
    use ExUnit.Case
    import AdventOfCode2022.Day05.PartOne

    test "day 5 part 1 sample" do
      assert answer("test/05/sample") == "CMZ"
    end

    test "day 5 part 1 actual" do
      assert answer("test/05/input") == "ZRLJGSCTR"
    end
  end

  defmodule PartTwo do
    use ExUnit.Case
    import AdventOfCode2022.Day05.PartTwo

    test "day 5 part 2 sample" do
      assert answer("test/05/sample") == "MCD"
    end

    test "day 5 part 2 actual" do
      assert answer("test/05/input") == "PRTTGRFPB"
    end
  end
end
