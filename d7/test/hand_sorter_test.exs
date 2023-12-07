defmodule HandSorterTest do
  use ExUnit.Case

  test "part1 test" do
    assert HandSorter.sort([
             %{
               type: :one_pair,
               type_strength: 2,
               points: 765,
               cards: [
                 %{card: "3", card_value: 3},
                 %{card: "2", card_value: 2},
                 %{card: "T", card_value: 10},
                 %{card: "3", card_value: 3},
                 %{card: "K", card_value: 13}
               ]
             },
             %{
               type: :three_of_kind,
               type_strength: 4,
               points: 684,
               cards: [
                 %{card: "T", card_value: 10},
                 %{card: "5", card_value: 5},
                 %{card: "5", card_value: 5},
                 %{card: "J", card_value: 11},
                 %{card: "5", card_value: 5}
               ]
             },
             %{
               type: :two_pair,
               type_strength: 3,
               points: 28,
               cards: [
                 %{card: "K", card_value: 13},
                 %{card: "K", card_value: 13},
                 %{card: "6", card_value: 6},
                 %{card: "7", card_value: 7},
                 %{card: "7", card_value: 7}
               ]
             },
             %{
               type: :two_pair,
               type_strength: 3,
               points: 220,
               cards: [
                 %{card: "K", card_value: 13},
                 %{card: "T", card_value: 10},
                 %{card: "J", card_value: 11},
                 %{card: "J", card_value: 11},
                 %{card: "T", card_value: 10}
               ]
             },
             %{
               type: :three_of_kind,
               type_strength: 4,
               points: 483,
               cards: [
                 %{card: "Q", card_value: 12},
                 %{card: "Q", card_value: 12},
                 %{card: "Q", card_value: 12},
                 %{card: "J", card_value: 11},
                 %{card: "A", card_value: 14}
               ]
             }
           ]) == [
             %{
               type: :one_pair,
               type_strength: 2,
               points: 765,
               cards: [
                 %{card: "3", card_value: 3},
                 %{card: "2", card_value: 2},
                 %{card: "T", card_value: 10},
                 %{card: "3", card_value: 3},
                 %{card: "K", card_value: 13}
               ]
             },
             %{
               type: :two_pair,
               type_strength: 3,
               points: 220,
               cards: [
                 %{card: "K", card_value: 13},
                 %{card: "T", card_value: 10},
                 %{card: "J", card_value: 11},
                 %{card: "J", card_value: 11},
                 %{card: "T", card_value: 10}
               ]
             },
             %{
               type: :two_pair,
               type_strength: 3,
               points: 28,
               cards: [
                 %{card: "K", card_value: 13},
                 %{card: "K", card_value: 13},
                 %{card: "6", card_value: 6},
                 %{card: "7", card_value: 7},
                 %{card: "7", card_value: 7}
               ]
             },
             %{
               type: :three_of_kind,
               type_strength: 4,
               points: 684,
               cards: [
                 %{card: "T", card_value: 10},
                 %{card: "5", card_value: 5},
                 %{card: "5", card_value: 5},
                 %{card: "J", card_value: 11},
                 %{card: "5", card_value: 5}
               ]
             },
             %{
               type: :three_of_kind,
               type_strength: 4,
               points: 483,
               cards: [
                 %{card: "Q", card_value: 12},
                 %{card: "Q", card_value: 12},
                 %{card: "Q", card_value: 12},
                 %{card: "J", card_value: 11},
                 %{card: "A", card_value: 14}
               ]
             }
           ]
  end
end
