defmodule D9Test do
  use ExUnit.Case
  doctest D9

  test "part1 test" do
    assert D9.part1("./inputs/input2.txt") == 114
  end

  test "part1 real" do
    assert D9.part1("./inputs/input.txt") == 1757008019
  end

  test "part2 test" do
    assert D9.part2("./inputs/input2.txt") == 2
  end

  test "part2 real" do
    assert D9.part2("./inputs/input.txt") == 995
  end
end
