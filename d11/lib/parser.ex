defmodule Parser do
  def transpose([[] | _]), do: []

  def transpose(m) do
    Enum.zip(m) |> Enum.map(&Tuple.to_list/1)
  end

  def explore_unique_connecstion(list, index) do
  end

  def parse(text, multipler) do
    matrix =
      text
      |> String.split("\n", trim: true)
      |> Enum.with_index()
      |> Enum.map(fn {line, i} ->
        cond do
          String.graphemes(line) |> Enum.all?(fn char -> char == "." end) ->
            for _z <- 1..multipler, do: line

          true ->
            line
        end
      end)
      |> List.flatten()
      |> Enum.map(fn line ->
        line
        |> String.split("", trim: true)
      end)
      |> transpose()
      |> Enum.with_index()
      |> Enum.map(fn {line, i} ->
        cond do
          line |> Enum.all?(fn char -> char == "." end) -> for _z <- 1..multipler, do: line
          true -> [line]
        end
      end)
      |> Enum.flat_map(fn e -> e end)
      |> transpose()
      |> Enum.map(fn line ->
        Enum.join(line, "")
      end)
      |> Enum.with_index()
      |> Enum.map(fn {line, y} ->
        line
        |> String.split("", trim: true)
        |> Enum.with_index()
        |> Enum.map(fn {char, x} ->
          %{id: "#{x}-#{y}", x: x, y: y, value: char}
        end)
      end)
  end
end
