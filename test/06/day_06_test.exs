defmodule Day06Test do
  defmodule PartOne do
    use ExUnit.Case
    import AdventOfCode2022.Day06.PartOne

    test "day 6 part 1 sample 1" do
      assert answer("test/06/sample1") == 7
    end

    test "day 6 part 1 sample 2" do
      assert answer("test/06/sample2") == 5
    end

    test "day 6 part 1 sample 3" do
      assert answer("test/06/sample3") == 6
    end

    test "day 6 part 1 sample 4" do
      assert answer("test/06/sample4") == 10
    end

    test "day 6 part 1 sample 5" do
      assert answer("test/06/sample5") == 11
    end

    test "day 6 part 1 input" do
      assert answer("test/06/input") == 1582
    end
  end

  defmodule PartTwo do
    use ExUnit.Case
    import AdventOfCode2022.Day06.PartTwo

    test "day 6 part 2 sample 1" do
      assert answer("test/06/sample1") == 19
    end

    test "day 6 part 2 sample 2" do
      assert answer("test/06/sample2") == 23
    end

    test "day 6 part 2 sample 3" do
      assert answer("test/06/sample3") == 23
    end

    test "day 6 part 2 sample 4" do
      assert answer("test/06/sample4") == 29
    end

    test "day 6 part 2 sample 5" do
      assert answer("test/06/sample5") == 26
    end

    test "day 6 part 2 input" do
      assert answer("test/06/input") == 3588
    end
  end
end
