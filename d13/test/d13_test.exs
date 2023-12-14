defmodule D13Test do
  use ExUnit.Case
  doctest D13

  test "P1 1" do
    assert D13.part1("./inputs/input2.txt") == 1005
  end

  test "P1 1.1" do
    assert D13.part1("./inputs/input3.txt") == 1300
  end

  test "P1 2" do
    assert D13.part1("./inputs/input.txt") == 27202
  end

  test "P2 1" do
    assert D13.part2("./inputs/input4.txt") == 400
  end

  test "P2 2" do
    assert D13.part2("./inputs/input.txt") == 699_909_023_130
  end
end
