defmodule D11Test do
  use ExUnit.Case
  doctest D11

  test "P1 1" do
    assert D11.part1("./inputs/input2.txt") == 374
  end

  test "P1 2" do
    assert D11.part1("./inputs/input.txt") == 10_422_930
  end

  test "P2 1" do
    assert D11.part2("./inputs/input2.txt", 10, 10) == 1030
  end

  test "P2 2" do
    assert D11.part2("./inputs/input2.txt", 10, 100) == 8410
  end

  test "P2 3" do
    assert D11.part2("./inputs/input.txt", 140, 1_000_000) == 699_909_023_130
  end
end
