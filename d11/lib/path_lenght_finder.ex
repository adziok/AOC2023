defmodule PathLenghtFinder do
  def calculate_distance(start, dest) do
    abs(start[:x] - dest[:x]) +
      abs(start[:y] - dest[:y])
  end

  def calculate_distance(start, dest, divider, multipler) do
    start_x =
      div(start[:x], divider) * multipler + rem(start[:x], divider)

    start_y =
      div(start[:y], divider) * multipler + rem(start[:y], divider)

    end_x =
      div(dest[:x], divider) * multipler + rem(dest[:x], divider)

    end_y =
      div(dest[:y], divider) * multipler + rem(dest[:y], divider)

    abs(start_x - end_x) + abs(start_y - end_y)
  end

  def possible_connections(galactics) do
    [head | rest] = galactics

    if(length(rest) > 1) do
      [{head, rest}, possible_connections(rest)]
    else
      [{head, rest}]
    end
  end

  def find(matrix) do
    galactics =
      matrix
      |> List.flatten()
      |> Enum.filter(fn e -> e[:value] == "#" end)

    possible_connections(galactics)
    |> List.flatten()
    |> Enum.map(fn {start, destinations} ->
      destinations
      |> Enum.map(fn dest ->
        dest
        |> calculate_distance(start)
      end)
    end)
    |> List.flatten()
    |> Enum.sum()
  end

  def find(matrix, divider, multipler) do
    galactics =
      matrix
      |> List.flatten()
      |> Enum.filter(fn e -> e[:value] == "#" end)

    possible_connections(galactics)
    |> List.flatten()
    |> Enum.map(fn {start, destinations} ->
      destinations
      |> Enum.map(fn dest ->
        dest
        |> calculate_distance(start, divider, multipler)
      end)
    end)
    |> List.flatten()
    |> Enum.sum()
  end
end
