defmodule D5Test do
  use ExUnit.Case
  doctest D5

  test "greets the world" do
    assert D5.part1("./inputs/input2.txt") == :world
  end
end
