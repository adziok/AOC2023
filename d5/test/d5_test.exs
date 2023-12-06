defmodule D5Test do
  use ExUnit.Case
  doctest D5

  test "part 1 test" do
    assert D5.part1("./inputs/input2.txt") == 35
  end

  test "part 1" do
    assert D5.part1("./inputs/input.txt") == 107_430_936
  end

  test "part 2 test" do
    assert D5.part2_final("./inputs/input2.txt") == 46
  end

  @tag timeout: 6000_000
  test "part 2" do
    ExUnit.configure(timeout: 6000_000)
    assert D5.part2_final("./inputs/input.txt") == 107_430_936
  end
end
