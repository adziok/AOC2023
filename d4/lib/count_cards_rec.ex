defmodule CountCardsRec do
  def generateList(start, length) do
    increment = 1
    Stream.iterate(start + 1, &(&1 + increment)) |> Enum.take(length)
  end

  def count(elements, index) do
    el =
      elements
      |> Enum.find(fn e -> e[:id] == index end)

    if el == nil do
      0
    else
      next_cards_list = generateList(el[:id], el[:matchingElementsCount])

      next_cards_list
      |> Enum.reduce(1, fn id, acc -> acc + count(elements, id) end)
    end
  end

  def execute(elements) do
    elements
    |> Enum.reduce(0, fn el, acc ->
      acc + count(elements, el[:id])
    end)
  end
end
