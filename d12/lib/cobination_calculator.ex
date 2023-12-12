defmodule CobinationCalculator do
  def count(graphemes, itertation) do
    if(length(graphemes) == 0) do
      [itertation]
    else
      [h | rest] = graphemes
      IO.inspect({graphemes, itertation})

      cond do
        h == "#" -> count(rest, itertation + 1)
        h == "?" -> count(rest, itertation + 1)
        h == "." -> [itertation, count(rest, 0)]
      end
    end
  end

  # {text: "???.###", groups: [1, 1, 3]}
  def calculate(t) do
    text = t[:text]
    groups = t[:groups]

    text_groups =
      text
      |> String.graphemes()

    text_groups |> count(0) |> IO.inspect()

    cond do
      length(text_groups) == length(groups) -> 0
      true -> 100_000
    end
  end
end
