defmodule D4Test do
  use ExUnit.Case
  doctest D4

  test "Part 1 - test" do
    assert D4.part1("./inputs/input2.txt") == 13
  end

  test "Part 1 - real" do
    assert D4.part1("./inputs/input.txt") == 26914
  end

  test "Part 2 - test" do
    assert D4.part2("./inputs/input2.txt") == 30
  end

  test "Part 2 - real" do
    assert D4.part2("./inputs/input.txt") == 13080971
  end
end
