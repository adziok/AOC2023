defmodule ParserATest do
  use ExUnit.Case

  test "parser only maped" do
    assert ParserA.parse_step(["seed-to-soil", "50 98 2", "52 50 48"]) ==
             [
               "seed",
               %{
                 to: "soil",
                 ranges: [
                   %{from: 0, to: 49, shift: 0, id: 0},
                   %{from: 50, to: 97, shift: 2, id: 1},
                   %{from: 98, to: 99, shift: -48, id: 2},
                   %{id: 3, to: 999000000000000, from: 100, shift: 0}
                 ]
               }
             ]
  end
end
