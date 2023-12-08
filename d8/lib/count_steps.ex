defmodule CountSteps do
  def find_i(steps, step_i, regions, curr_region, look_for, iteration) do
    cond do
      length(steps) == step_i ->
        find_i(steps, 0, regions, curr_region, look_for, iteration)

      Map.get(regions[curr_region], String.to_atom(Enum.at(steps, step_i))) == look_for ->
        iteration

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

  def find_i_many(steps, step_i, regions, curr_regions, look_for, iteration) do
    IO.inspect(curr_regions)
    IO.inspect(look_for)
    IO.inspect(iteration)
    cond do
      length(steps) == step_i ->
        find_i_many(steps, 0, regions, curr_regions, look_for, iteration)

      length(
        (curr_regions
         |> Enum.map(fn curr_region ->
           Map.get(regions[curr_region], String.to_atom(Enum.at(steps, step_i)))
         end)) --
            look_for
      ) == 0 ->
        iteration

      true ->
        find_i_many(
          steps,
          step_i + 1,
          regions,
          curr_regions
          |> Enum.map(fn curr_region ->
            Map.get(regions[curr_region], String.to_atom(Enum.at(steps, step_i)))
          end),
          look_for,
          iteration + 1
        )
    end
  end

  def count_many(steps, regions, start, finish) do
    find_i_many(steps, 0, regions, start, finish, 1)
  end
end
