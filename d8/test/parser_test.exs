defmodule ParserTest do
  use ExUnit.Case

  test "part1 test" do
    assert Parser.parse("32T3K 765") == 1
  end
end
