defmodule HandCalculator do
  def cards_types do
    %{
      five_of_kind: 7,
      four_of_kind: 6,
      full_house: 5,
      three_of_kind: 4,
      two_pair: 3,
      one_pair: 2,
      high_card: 1
    }
  end

  def count_cards(cards) do
    cards
    |> Enum.map(fn e -> e[:card_value] end)
    |> Enum.group_by(fn e -> e end)
    |> Enum.to_list()
    |> Enum.map(fn {card_value, list} -> {card_value, length(list)} end)
    |> Enum.sort_by(fn {_card_value, list_length} -> list_length end)
    |> Enum.reverse()
  end

  def count_to_card_type(list_of_count) do
    cond do
      length(list_of_count) == 5 -> :high_card
      length(list_of_count) == 4 -> :one_pair
      length(list_of_count) == 3 && Enum.at(list_of_count, 1) == 2 -> :two_pair
      length(list_of_count) == 3 && Enum.at(list_of_count, 1) == 1 -> :three_of_kind
      length(list_of_count) == 2 && Enum.at(list_of_count, 1) == 2 -> :full_house
      length(list_of_count) == 2 && Enum.at(list_of_count, 1) == 1 -> :four_of_kind
      length(list_of_count) == 1 -> :five_of_kind
      length(list_of_count) == 0 -> :five_of_kind # 5 jokers case
    end
  end

  def calculate(hand) do
    type =
      count_cards(hand[:cards])
      |> Enum.map(fn {_card_value, list_length} -> list_length end)
      |> count_to_card_type

    Map.merge(hand, %{type: type, type_strength: cards_types()[type]})

    Map.merge(hand, %{type: type, type_strength: cards_types()[type]})
  end

  def calculate_j(hand) do
    counted_cards =
      count_cards(hand[:cards])
      |> Enum.filter(fn {card_value, _l} -> card_value != 1 end)

    joker_card =
      count_cards(hand[:cards])
      |> Enum.find(fn {card_value, _l} -> card_value == 1 end)

    if(joker_card != nil) do
      {_, jokers_count} = joker_card

      type =
        counted_cards
        |> Enum.with_index()
        |> Enum.map(fn {{_card_value, list_length}, index} ->
          if(index == 0) do
            list_length + jokers_count
          else
            list_length
          end
        end)
        |> count_to_card_type

      Map.merge(hand, %{type: type, type_strength: cards_types()[type]})
    else
      type =
        counted_cards
        |> Enum.map(fn {_card_value, list_length} -> list_length end)
        |> count_to_card_type

      Map.merge(hand, %{type: type, type_strength: cards_types()[type]})
    end
  end
end
