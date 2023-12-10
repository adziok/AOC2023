defmodule Parser do
  def char_to_direction(char) do
    dir = %{
      |: [%{x: char[:x], y: char[:y] + 1}, %{x: char[:x], y: char[:y] - 1}],
      -: [%{x: char[:x] + 1, y: char[:y]}, %{x: char[:x] - 1, y: char[:y]}],
      L: [%{x: char[:x], y: char[:y] + 1}, %{x: char[:x], y: char[:y] - 1}],
      J: [%{x: char[:x], y: char[:y] + 1}, %{x: char[:x], y: char[:y] - 1}],
      "7": [%{x: char[:x], y: char[:y] + 1}, %{x: char[:x], y: char[:y] - 1}],
      F: [%{x: char[:x], y: char[:y] + 1}, %{x: char[:x], y: char[:y] - 1}],
      .: [],
      S: []
    }
  end

  def parse(text) do
    text
    |> String.split("\n", trim: true)
    |> Enum.with_index()
    |> Enum.map(fn {line, y} ->
      line
      |> String.split("", trim: true)
      |> Enum.with_index()
      |> Enum.map(fn {char, x} ->
        %{x: x, y: y, value: char}
      end)
    end)
  end
end
