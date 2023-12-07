defmodule HandCalculatorTest do
  use ExUnit.Case

  test "part1 test" do
    assert HandCalculator.calculate(%{
             cards: [
               %{card: "3", card_value: 3},
               %{card: "2", card_value: 2},
               %{card: "T", card_value: 10},
               %{card: "3", card_value: 3},
               %{card: "K", card_value: 13}
             ],
             points: 765
           }) == %{
             type: :one_pair,
             type_strength: 2,
             cards: [
               %{card_value: 3, card: "3"},
               %{card_value: 2, card: "2"},
               %{card_value: 10, card: "T"},
               %{card_value: 3, card: "3"},
               %{card_value: 13, card: "K"}
             ],
             points: 765
           }
  end

  test "With J" do
    assert HandCalculator.calculate_j(%{
             cards: [
               %{card: "T", card_value: 10},
               %{card: "J", card_value: 1},
               %{card: "T", card_value: 10},
               %{card: "J", card_value: 1},
               %{card: "K", card_value: 13}
             ],
             points: 765
           }) == %{
             type: :four_of_kind,
             type_strength: 6,
             cards: [
               %{card: "T", card_value: 10},
               %{card: "J", card_value: 1},
               %{card: "T", card_value: 10},
               %{card: "J", card_value: 1},
               %{card: "K", card_value: 13}
             ],
             points: 765
           }
  end
end
