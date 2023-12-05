defmodule D5Test do
  use ExUnit.Case
  doctest D5

  # test "part 1 test" do
  #   assert D5.part1("./inputs/input2.txt") == 35
  # end

  test "part 1" do
    assert D5.part1("./inputs/input.txt") == 107430936
  end


  # test "part 2 test" do
  #   assert D5.part2("./inputs/input2.txt") == 46
  # end

  # test "part 2" do
  #   assert D5.part2("./inputs/input.txt") == 107430936
  # end
end
