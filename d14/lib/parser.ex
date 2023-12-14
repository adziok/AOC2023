defmodule Parser do
  def transpose([[] | _]), do: []

  def transpose(m) do
    Enum.zip(m) |> Enum.map(&Tuple.to_list/1)
  end

  def parse(texts) do
    number_of_lines =
      texts
      |> String.split("\n", trim: true)
      |> length()

    texts
    |> String.split("\n", trim: true)
    |> Enum.map(fn text ->
      text
      |> String.graphemes()
    end)
    |> transpose()
    |> Enum.map(fn els ->
      els
      |> visit_and_replace(false, [])
    end)
    |> transpose()
    |> Enum.with_index()
    |> Enum.map(fn {list, index} ->
      o_count = list
      |> Enum.filter(fn e -> e == "O" end)
      |> length()

      o_count * (number_of_lines - index)
    end)
    |> Enum.sum()

  end

  def parse2(texts) do
    number_of_lines =
      texts
      |> String.split("\n", trim: true)
      |> length()

    texts
    |> String.split("\n", trim: true)
    |> Enum.map(fn text ->
      text
      |> String.graphemes()
    end)
    |> transpose()
    |> Enum.map(fn els ->
      els
      |> visit_and_replace(false, [])
    end)
    |> IO.inspect()
    |> transpose()
    |> IO.inspect()
    |> Enum.with_index()
    |> IO.inspect()
    |> Enum.map(fn {list, index} ->
      o_count = list
      |> Enum.filter(fn e -> e == "O" end)
      |> length()

      o_count * (number_of_lines - index)
    end)
    |> Enum.sum()

  end

  def visit_and_replace(elements, changed, result) do
    if(length(elements) == 1) do
      r =
        [result, [List.last(elements)]] |> List.flatten()

      if(changed == false) do
        r
      else
        visit_and_replace(r, false, [])
      end
    else
      [first | els] = elements

      cond do
        first == "O" ->
          visit_and_replace(els, changed, [result, first])

        first == "#" ->
          visit_and_replace(els, changed, [result, first])

        first == "." ->
          [second | rest] = els

          cond do
            second == "O" ->
              visit_and_replace(List.flatten([first], rest), true, [result, second])

            second == "#" ->
              visit_and_replace(els, changed, [result, first])

            second == "." ->
              visit_and_replace(els, changed, [result, first])
          end
      end
    end
  end
end
