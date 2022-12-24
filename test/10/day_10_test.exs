defmodule Day10Test do
  defmodule PartOne do
    use ExUnit.Case
    import AdventOfCode2022.Day10.PartOne

    setup do
      File.cd("test/10/")
      on_exit(fn -> File.cd("../../") end)
    end

    test "day 10 part 1 sample" do
      assert answer("sample") == 13140
    end

    test "day 10 part 1 actual" do
      assert answer("input") == 13920
    end
  end

  defmodule PartTwo do
    use ExUnit.Case
    import AdventOfCode2022.Day10.PartTwo

    setup do
      File.cd("test/10/")
      on_exit(fn -> File.cd("../../") end)
    end

    test "day 10 part 2 sample" do
      expected = """
      ##..##..##..##..##..##..##..##..##..##..
      ###...###...###...###...###...###...###.
      ####....####....####....####....####....
      #####.....#####.....#####.....#####.....
      ######......######......######......####
      #######.......#######.......#######.....
      """

      assert answer("sample") == expected
    end

    test "day 10 part 2 actual" do
      # EGLHBLFJ
      expected = """
      ####..##..#....#..#.###..#....####...##.
      #....#..#.#....#..#.#..#.#....#.......#.
      ###..#....#....####.###..#....###.....#.
      #....#.##.#....#..#.#..#.#....#.......#.
      #....#..#.#....#..#.#..#.#....#....#..#.
      ####..###.####.#..#.###..####.#.....##..
      """

      assert answer("input") == expected
    end
  end
end
