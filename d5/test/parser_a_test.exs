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
                   %{id: 3, to: 999_000_000_000_000, from: 100, shift: 0}
                 ]
               }
             ]
  end

  test "papa" do
    assert ParserA.parse_step([
             "temperature-to-humidity",
             "3056037605 2829211160 523334807",
             "321779731 0 47068359",
             "3924298564 3372771457 370668732",
             "1103457901 562085848 156691500",
             "0 240306117 321779731",
             "368848090 1020196358 239953043",
             "2829211160 3743440189 226826445",
             "608801133 718777348 301419010",
             "3579372412 3970266634 324700662",
             "3915140668 3363613561 9157896",
             "910220143 232146746 8159371",
             "3904073074 3352545967 11067594",
             "918379514 47068359 185078387"
           ]) ==
             [
               "temperature",
               %{
                 to: "humidity",
                 ranges: [
                   %{from: 0, to: 49, shift: 0, id: 0},
                   %{from: 50, to: 97, shift: 2, id: 1},
                   %{from: 98, to: 99, shift: -48, id: 2},
                   %{id: 3, to: 999_000_000_000_000, from: 100, shift: 0}
                 ]
               }
             ]
  end
end
