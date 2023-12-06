defmodule D6Test do
  use ExUnit.Case
  doctest D6

  test "greets the world" do
    assert D6.part1("./inputs/input2.txt") == 288
  end

  test "greets the r" do
    assert D6.part1("./inputs/input.txt") == 1624896
  end

  test "greets the world2" do
    assert D6.part2("./inputs/input2.txt") == 71503
  end

  test "greets the r2" do
    assert D6.part2("./inputs/input.txt") == 32583852
  end
end
