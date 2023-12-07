defmodule ParserTest do
  use ExUnit.Case

  test "part1 test" do
    assert Parser.parse_hand("32T3K 765") == %{
             cards: [
               %{card: "3", card_value: 3},
               %{card: "2", card_value: 2},
               %{card: "T", card_value: 10},
               %{card: "3", card_value: 3},
               %{card: "K", card_value: 13}
             ],
             points: 765
           }
  end
end
