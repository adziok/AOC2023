defmodule ParserCTest do
  use ExUnit.Case

  test "parser only maped-1" do
    assert ParserC.parse_seeds([0, 1], %{
             to: "soil",
             ranges: [
               %{from: 0, to: 49, shift: 0, id: 0},
               %{from: 50, to: 97, shift: 2, id: 1},
               %{from: 98, to: 99, shift: -48, id: 2},
               %{id: 3, to: 999_000_000_000_000, from: 100, shift: 0}
             ]
           }) ==
             [
               [0, 1]
             ]
  end

  # test "parser only maped0" do
  #   assert ParserC.parse_seeds([45, 101], %{
  #            to: "soil",
  #            ranges: [
  #              %{from: 0, to: 49, shift: 0, id: 0},
  #              %{from: 50, to: 97, shift: 2, id: 1},
  #              %{from: 98, to: 99, shift: -48, id: 2},
  #              %{id: 3, to: 999000000000000, from: 100, shift: 0}
  #            ]
  #          }) ==
  #            [
  #              [45, 49],
  #              [52, 99],
  #              [50, 51],
  #              [100,101]
  #            ]
  # end

  # test "parser only maped1" do
  #   assert ParserC.parse_seeds([45, 55], %{
  #            to: "soil",
  #            ranges: [
  #              %{from: 0, to: 49, shift: 0, id: 0},
  #              %{from: 50, to: 97, shift: 2, id: 1},
  #              %{from: 98, to: 99, shift: -48, id: 2},
  #              %{id: 3, to: 999000000000000, from: 100, shift: 0}
  #            ]
  #          }) ==
  #            [
  #              [45, 49],
  #              [52, 57]
  #            ]
  # end

  # test "parser only maped2" do
  #   assert ParserC.parse_seeds([45, 46], %{
  #            to: "soil",
  #            ranges: [
  #              %{from: 0, to: 49, shift: 0, id: 0},
  #              %{from: 50, to: 97, shift: 2, id: 1},
  #              %{from: 98, to: 99, shift: -48, id: 2},
  #              %{id: 3, to: 999000000000000, from: 100, shift: 0}
  #            ]
  #          }) ==
  #            [
  #              [45, 46]
  #            ]
  # end

  # test "parser only maped3" do
  #   assert ParserC.parse_seeds([50, 55], %{
  #            to: "soil",
  #            ranges: [
  #              %{from: 0, to: 49, shift: 0, id: 0},
  #              %{from: 50, to: 97, shift: 2, id: 1},
  #              %{from: 98, to: 99, shift: -48, id: 2},
  #              %{id: 3, to: 999000000000000, from: 100, shift: 0}
  #            ]
  #          }) ==
  #            [
  #              [52, 57]
  #            ]
  # end

  # test "parser only maped4" do
  #   assert ParserC.parse_seeds([55, 67], %{
  #            to: "soil",
  #            ranges: [
  #              %{from: 0, to: 49, shift: 0, id: 0},
  #              %{from: 50, to: 97, shift: 2, id: 1},
  #              %{from: 98, to: 99, shift: -48, id: 2},
  #              %{id: 3, to: 999000000000000, from: 100, shift: 0}
  #            ]
  #          }) ==
  #            [
  #              [57, 69]
  #            ]

  #   assert ParserC.parse_seeds([79, 92], %{
  #            to: "soil",
  #            ranges: [
  #              %{from: 0, to: 49, shift: 0, id: 0},
  #              %{from: 50, to: 97, shift: 2, id: 1},
  #              %{from: 98, to: 99, shift: -48, id: 2},
  #              %{id: 3, to: 999000000000000, from: 100, shift: 0}
  #            ]
  #          }) ==
  #            [
  #              [81, 94]
  #            ]
  # end
end
