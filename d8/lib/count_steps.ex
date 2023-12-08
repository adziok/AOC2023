defmodule CountSteps do
  def find_i(steps, step_i, regions, curr_region, look_for, iteration) do
    cond do
      length(steps) == step_i ->
        find_i(steps, 0, regions, curr_region, look_for, iteration)

      Map.get(regions[curr_region], String.to_atom(Enum.at(steps, step_i))) == look_for ->
        iteration
        |> IO.inspect()

      true ->
        find_i(
          steps,
          step_i + 1,
          regions,
          Map.get(regions[curr_region], String.to_atom(Enum.at(steps, step_i))),
          look_for,
          iteration + 1
        )
    end
  end

  def count(steps, regions, start, finish) do
    find_i(steps, 0, regions, start, finish, 1)
  end

  def find_i_f(steps, step_i, regions, curr_region, look_for, iteration) do
    cond do
      length(steps) == step_i ->
        find_i_f(steps, 0, regions, curr_region, look_for, iteration)

      String.at(Map.get(regions[curr_region], String.to_atom(Enum.at(steps, step_i))), 2) == "Z" ->
        iteration

      true ->
        find_i_f(
          steps,
          step_i + 1,
          regions,
          Map.get(regions[curr_region], String.to_atom(Enum.at(steps, step_i))),
          look_for,
          iteration + 1
        )
    end
  end

  def count_f(steps, regions, start, finish) do
    find_i_f(steps, 0, regions, start, finish, 1)
  end
end
