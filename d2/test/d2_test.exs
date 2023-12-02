defmodule D2Test do
  use ExUnit.Case

  test "simpleExample" do
    assert D2.execute("./inputs/input.txt", %{red: 12, green: 13, blue: 14}) == 2685
  end

  test "simpleExample2" do
    assert D2.execute2("./inputs/input.txt") == 83707
  end
end
