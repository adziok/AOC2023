defmodule D7Test do
  use ExUnit.Case
  doctest D7

  test "part1 test" do
    assert D7.part1("./inputs/input2.txt") == 6440
  end

  @tag timeout: :infinity
  test "part1 real" do
    assert D7.part1("./inputs/input.txt") == 250_602_641
  end

  test "part2 test" do
    assert D7.part2("./inputs/input2.txt") == 5905
  end

  test "part2 real" do
    assert D7.part2("./inputs/input.txt") == 6440
  end
end
