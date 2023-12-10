defmodule Traverser do
  def move(matrix, prev_move, curr_move, iteration) do
    if(curr_move[:value] == "S") do
      iteration
    else
      next_move_cord =
        curr_move[:moves]
        |> Enum.find(fn move ->
          move[:x] != prev_move[:x] || move[:y] != prev_move[:y]
        end)

      next_move =
        Enum.at(
          Enum.at(matrix, next_move_cord[:y]),
          next_move_cord[:x]
        )

      move(matrix, curr_move, next_move, iteration + 1)
    end
  end

  def traverse(matrix) do
    start_point =
      matrix
      |> List.flatten()
      |> Enum.find(fn point -> point[:value] == "S" end)

    next_move =
      Enum.at(
        Enum.at(matrix, Enum.at(start_point[:moves], 0)[:y]),
        Enum.at(start_point[:moves], 0)[:x]
      )

    move(matrix, start_point, next_move, 0)
  end
end
