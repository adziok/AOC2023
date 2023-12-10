defmodule Parser do
  def char_to_direction(char) do
    dir = %{
      |: [%{x: char[:x], y: char[:y] + 1}, %{x: char[:x], y: char[:y] - 1}],
      -: [%{x: char[:x] + 1, y: char[:y]}, %{x: char[:x] - 1, y: char[:y]}],
      L: [%{x: char[:x], y: char[:y] - 1}, %{x: char[:x] + 1, y: char[:y]}],
      J: [%{x: char[:x], y: char[:y] - 1}, %{x: char[:x] - 1, y: char[:y]}],
      "7": [%{x: char[:x], y: char[:y] + 1}, %{x: char[:x] - 1, y: char[:y]}],
      F: [%{x: char[:x], y: char[:y] + 1}, %{x: char[:x] + 1, y: char[:y]}],
      .: [],
      S: []
    }

    Map.get(dir, String.to_atom(char[:value]))
  end

  def parse(text) do
    matrix =
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
        |> Enum.map(fn point ->
          Map.merge(point, %{moves: char_to_direction(point)})
        end)
      end)

    matrix
    |> Enum.map(fn row ->
      row
      |> Enum.map(fn point ->
        if(point[:value] == "S") do
          moves =
            [
              Enum.at(Enum.at(matrix, point[:y]), point[:x] + 1),
              Enum.at(Enum.at(matrix, point[:y]), point[:x] - 1),
              Enum.at(Enum.at(matrix, point[:y] + 1), point[:x]),
              Enum.at(Enum.at(matrix, point[:y] - 1), point[:x])
            ]
            |> Enum.filter(fn e ->
              e[:moves]
              |> Enum.find(fn move ->
                move[:x] == point[:x] && move[:y] == point[:y]
              end)
            end)

          Map.merge(point, %{moves: moves})
        else
          point
        end
      end)
    end)
  end
end
