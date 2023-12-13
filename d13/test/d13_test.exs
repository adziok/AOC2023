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

  # test "P2 1" do
  #   assert D12.part2("./inputs/input2.txt", 10, 10) == 1030
  # end

  # test "P2 2" do
  #   assert D11.part2("./inputs/input.txt", 140, 1_000_000) == 699_909_023_130
  # end
end
