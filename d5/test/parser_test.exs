defmodule ParserTest do
  use ExUnit.Case

  test "parser in range" do
    assert Parser.map_parser(["seed-to-soil", "5 10 1", "7 13 1"], 10) == [
      "seed-to-soil",
      {0, 0},
      {1, 1},
      {2, 2},
      {3, 3},
      {4, 4},
      {5, 10},
      {6, 11},
      {7, 13},
      {8, 14},
      {9, 9},
      {10, 10},
    ]
  end


  test "parser only maped" do
    assert Parser.map_parser2(["seed-to-soil", "50 98 2", "52 50 48"]) == %{
      50 => 52,
      51 => 53,
      52 => 54,
      53 => 55,
      54 => 56,
      55 => 57,
      56 => 58,
      57 => 59,
      58 => 60,
      59 => 61,
      60 => 62,
      61 => 63,
      62 => 64,
      63 => 65,
      64 => 66,
      65 => 67,
      66 => 68,
      67 => 69,
      68 => 70,
      69 => 71,
      70 => 72,
      71 => 73,
      72 => 74,
      73 => 75,
      74 => 76,
      75 => 77,
      76 => 78,
      77 => 79,
      78 => 80,
      79 => 81,
      80 => 82,
      81 => 83,
      82 => 84,
      83 => 85,
      84 => 86,
      85 => 87,
      86 => 88,
      87 => 89,
      88 => 90,
      89 => 91,
      90 => 92,
      91 => 93,
      92 => 94,
      93 => 95,
      94 => 96,
      95 => 97,
      96 => 98,
      97 => 99,
      98 => 100,
      99 => 51,
      100 => 52
    }
  end
end
