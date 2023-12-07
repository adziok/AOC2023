defmodule Parser do
  def cards_mapper(card, true) do
    map = %{
      "A" => 14,
      "K" => 13,
      "Q" => 12,
      "J" => 1,
      "T" => 10
    }

    case Integer.parse(card) do
      {int, _} -> int
      :error -> map[card]
    end
  end

  def cards_mapper(card, false) do
    map = %{
      "A" => 14,
      "K" => 13,
      "Q" => 12,
      "J" => 11,
      "T" => 10
    }

    case Integer.parse(card) do
      {int, _} -> int
      :error -> map[card]
    end
  end

  def parse(text) do
    text
    |> String.split("\n", trim: true)
    |> Enum.map(fn line -> parse_hand(line, false) end)
  end

  def parse_j(text) do
    text
    |> String.split("\n", trim: true)
    |> Enum.map(fn line -> parse_hand(line, true) end)
  end

  def parse_hand(line, with_j) do
    [cards, points] =
      line
      |> String.split(" ", trim: true)

    parsed_cards =
      cards
      |> String.split("", trim: true)
      |> Enum.map(fn card ->
        %{
          card: card,
          card_value: cards_mapper(card, with_j)
        }
      end)

    %{
      points:
        Integer.parse(points)
        |> case do
          {num, _} -> num
        end,
      cards: parsed_cards
    }
  end
end
