defmodule HandSorter do
  def compare_hands(hands, current_checked_value, card_index, result) do
    cond do
      current_checked_value < 0 || length(result) == length(hands) ->
        result

      length(result) == length(hands) - 1 ->
        hands
        |> Enum.filter(fn -> nil end)

      true ->
        highest_hands =
          hands
          |> Enum.filter(fn hand ->
            Enum.at(hand[:cards], card_index)[:card_value] == current_checked_value
          end)

        cond do
          length(highest_hands) == 1 ->
            compare_hands(
              hands,
              current_checked_value - 1,
              card_index,
              List.flatten([highest_hands, result])
            )

          length(highest_hands) == 0 ->
            compare_hands(hands, current_checked_value - 1, card_index, result)

          length(highest_hands) > 1 ->
            compare_hands(
              hands,
              current_checked_value - 1,
              card_index,
              List.flatten([compare_hands(highest_hands, 14, card_index + 1, result), result])
            )
        end
    end
  end

  def sort(hands) do
    hands
    |> Enum.group_by(fn e -> e[:type_strength] end)
    |> Enum.to_list()
    |> Enum.map(fn {_i, hands} ->
      if(length(hands) > 1) do
        compare_hands(hands, 14, 0, [])
      else
        hands
      end
    end)
    |> List.flatten()
  end
end
