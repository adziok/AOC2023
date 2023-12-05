defmodule D5Test do
  use ExUnit.Case
  doctest D5

  test "part 1 test" do
    assert D5.part1("./inputs/input2.txt") == 35
  end

  # test "part 1" do
  #   assert D5.part1("./inputs/input.txt") == 35
  # end
end
