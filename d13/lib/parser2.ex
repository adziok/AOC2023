defmodule Parser2 do
  def transpose([[] | _]), do: []

  def transpose(m) do
    Enum.zip(m) |> Enum.map(&Tuple.to_list/1)
  end

  def ee(list) do
    list
    |> Enum.filter(fn list ->
      m = div(length(list), 2)
      if(rem(length(list), 2) == 1) do
        [explore(list, m, 0), explore(list, m + 1, 0)]
        |> Enum.any?(fn e -> e == true end)
      else
        explore(list, m, 0)
      end
    end)
  end

  def parse(texts) do
    vertical_mir =
      texts
      |> String.split("\n\n", trim: true)
      |> Enum.map(fn text ->
        text
        |> String.split("\n", trim: true)
        |> Enum.with_index()
        # |> Enum.group_by(fn {value, _index} -> value end)
      end)
      |> ee()
      |> IO.inspect()

    horizontal_mir =
      texts
      |> String.split("\n\n", trim: true)
      |> Enum.map(fn text ->
        text
        |> String.split("\n", trim: true)
        |> Enum.map(fn text ->
          text
          |> String.graphemes()
        end)
        |> transpose
        |> Enum.map(fn text ->
          text
          |> Enum.join("")
        end)
        |> Enum.with_index()
        # |> Enum.group_by(fn {value, _index} -> value end)
      end)
      |> ee()
      |> IO.inspect()

    # h_c =
    #   horizontal_mir
    #   |> Enum.map(fn hor ->
    #     hor
    #     |> Enum.to_list()
    #     |> Enum.find(fn {_, list} ->
    #       if length(list) == 1 do
    #         false
    #       else
    #         has_elements_with_index_one_after_another(list, 0)
    #       end
    #     end)
    #     |> extract_index_and_multiple(1)
    #   end)
    #   |> Enum.sum()

    # v_c =
    #   vertical_mir
    #   |> Enum.map(fn hor ->
    #     hor
    #     |> Enum.to_list()
    #     |> Enum.find(fn {_, list} ->
    #       if length(list) == 1 do
    #         false
    #       else
    #         has_elements_with_index_one_after_another(list, 0)
    #       end
    #     end)
    #     |> extract_index_and_multiple(100)
    #   end)
    #   |> Enum.sum()

    # h_c + v_c
  end

  def explore(list, center_index, shift) do
    is_odd = rem(length(list), 2) == 0

    odd_true_case = is_odd && center_index - shift < 0
    nodd_true_case = !is_odd && center_index - shift == 0 || center_index + shift + 1 == length(list)

    if odd_true_case || nodd_true_case do
      true
    else
      {left_value,_} = Enum.at(list, center_index - shift)
      {right_value,_} = Enum.at(list, center_index + shift + 1)
      if left_value == right_value do
        explore(list, center_index, shift + 1)
      else
        false
      end
    end
  end

  def extract_index_and_multiple(d, multiple) do
    {_, list} = d
    {_, mirror_index_start} = Enum.at(list, 0)

    (mirror_index_start + 1) * multiple
  end

  def has_elements_with_index_one_after_another(list, el_i) do
    if length(list) == el_i + 1 do
      false
    else
      {_, curr_i} = Enum.at(list, el_i)
      {_, next_i} = Enum.at(list, el_i + 1)

      if curr_i + 1 == next_i  do
        true
      else
        has_elements_with_index_one_after_another(list, el_i + 1)
      end
    end
  end
end
