defmodule D10Test do
  use ExUnit.Case
  doctest D10

  test "P1 1" do
    assert D10.part1("./inputs/input3.txt") == 4
  end

  test "P1 2" do
    assert D10.part1("./inputs/input2.txt") == 8
  end

  test "P1 3" do
    assert D10.part1("./inputs/input.txt") == 6864
  end
end
