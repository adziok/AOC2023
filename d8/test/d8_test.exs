defmodule D8Test do
  use ExUnit.Case
  doctest D8

  # test "part1 test" do
  #   assert D8.part1("./inputs/input2.txt") == 6
  # end

  # test "part1 test 2" do
  #   assert D8.part1("./inputs/input3.txt") == 2
  # end

  # @tag timeout: :infinity
  # test "part1 real" do
  #   assert D8.part1("./inputs/input.txt") == 19199
  # end

  # test "part2 test" do
  #   assert D8.part2("./inputs/input4.txt") == 6
  # end

  @tag timeout: :infinity
  test "part2 real" do
    assert D8.part2("./inputs/input.txt") == 251037509
  end
end
