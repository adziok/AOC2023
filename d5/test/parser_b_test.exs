defmodule ParserBTest do
  use ExUnit.Case

  test "parser only maped" do
    assert ParserB.parse_seeds("seeds: 79 14 55 13") ==
             [
               [55, 67],
               [79, 92]
             ]
  end
end
