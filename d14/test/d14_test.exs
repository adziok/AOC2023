defmodule D14Test do
  use ExUnit.Case
  doctest D14

  test "P1 1" do
    assert D14.part1("./inputs/input2.txt") == 136
  end

  test "P1 2" do
    assert D14.part1("./inputs/input.txt") == 105784
  end

  # test "P2 1" do
  #   assert D14.part2("./inputs/input4.txt") == 400
  # end

  # test "P2 2" do
  #   assert D14.part2("./inputs/input.txt") == 699_909_023_130
  # end
end
