defmodule D3Test do
  use ExUnit.Case
  doctest D3

  test "greets the world" do
    assert D3.execute("./inputs/input.txt") == ""
  end
end
