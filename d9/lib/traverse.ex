defmodule Traverse do
  def visit_element(elements, curr_index) do
    [curr, next] = [Enum.at(elements, curr_index), Enum.at(elements, curr_index + 1)]
    should_call_next = Enum.at(elements, curr_index + 2)

    if(should_call_next != nil) do
      [next - curr, visit_element(elements, curr_index + 1)]
    else
      [next - curr]
    end
  end

  def traverse_level(elements) do
    res =
      visit_element(elements, 0)
      |> List.flatten()

    cond do
      length(res |> Enum.filter(fn e -> e != 0 end)) > 0 ->
        [
          %{res: res},
          traverse_level(res)
        ]

      true ->
        %{res: res}
    end
  end

  def traverse(elements) do
    res =
      [%{res: elements}, traverse_level(elements)]
      |> List.flatten()

    res
    |> Enum.with_index()
    |> Enum.map(fn {elements, i} -> {i + 1, Map.get(elements, :res)} end)
    |> Map.new()
    |> Map.merge(%{deep: length(res)})
  end
end
