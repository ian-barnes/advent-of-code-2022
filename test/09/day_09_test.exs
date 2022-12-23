defmodule Day09Test do
  defmodule PartOne do
    use ExUnit.Case
    import AdventOfCode2022.Day09.PartOne

    setup do
      File.cd("test/09")
      on_exit(fn -> File.cd("../..") end)
    end

    test "day 9 part 1 sample" do
      assert answer("sample") == 13
    end

    test "day 9 part 1 actual" do
      assert answer("input") == 6190
    end
  end

  defmodule PartTwo do
    use ExUnit.Case
    import AdventOfCode2022.Day09.PartTwo

    setup do
      File.cd("test/09")
      on_exit(fn -> File.cd("../..") end)
    end

    test "day 9 part 2 sample" do
      assert answer("sample") == 1
    end

    test "day 9 part 2 sample2" do
      assert answer("sample2") == 36
    end

    test "day 9 part 2 actual" do
      assert answer("input") == 2516
    end
  end
end
