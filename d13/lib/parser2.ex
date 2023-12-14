defmodule Parser2 do
  def transpose([[] | _]), do: []

  def transpose(m) do
    Enum.zip(m) |> Enum.map(&Tuple.to_list/1)
  end

  def eee2(list) do
    list
    |> Enum.map(fn list ->
      if(rem(length(list), 2) == 1) do
        1..(length(list) - 1)
        |> Enum.map(fn e -> explore(list, e - 1, 0, 0) end)
        |> List.flatten()
        |> Enum.filter(fn e -> e != false end)
      else
        1..(length(list) - 1)
        |> Enum.map(fn e -> explore(list, e - 1, 0, 0) end)
        |> Enum.filter(fn e -> e != false end)

        # explore(list, m - 1, 0)
      end
    end)
    |> Enum.map(fn list ->
      list
      |> Enum.take(1)
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
      end)
      |> eee2()
      |> Enum.with_index()
      |> Enum.filter(fn {list, index} ->
        length(list) > 0
      end)
      |> List.flatten()
      |> Enum.map(fn {[d], index} ->
        {(d + 1) * 100, index}
      end)

    vertical_mir_sum =
      vertical_mir
      |> Enum.map(fn {d, index} ->
        d
      end)
      |> Enum.sum()

    vertical_mir_indexes =
      vertical_mir
      |> Enum.map(fn {d, index} ->
        index
      end)

    horizontal_mir = 0
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
      end)
      |> Enum.with_index()
      |> Enum.filter(fn {list, index} -> vertical_mir_indexes |> Enum.any?(fn v_i -> v_i == index end) end)
      |> Enum.map(fn {d, index} ->
        d
      end)
      |> eee2()
      |> List.flatten()
      |> Enum.map(fn d ->
        (d + 1)
      end)
      |> Enum.sum()

    horizontal_mir + vertical_mir_sum
  end

  def explore(list, center_index, shift, smuge_occurencies) do
    is_odd = rem(length(list), 2) == 0

    odd_true_case =
      is_odd && (center_index - shift < 0 || center_index + shift + 1 >= length(list))

    nodd_true_case =
      !is_odd && (center_index - shift < 0 || center_index + shift + 1 == length(list))

    if odd_true_case || nodd_true_case do
      # IO.inspect(center_index, label: "CURENT_INDEX")
      # IO.inspect({list, center_index, shift, smuge_occurencies})
      if smuge_occurencies > 1 do
        false
      else
        center_index
      end
    else
      {left_value, li} = Enum.at(list, center_index - shift)
      {right_value, ri} = Enum.at(list, center_index + shift + 1)

      left_value_graphemes_with_index =
        left_value
        |> String.graphemes()
        |> Enum.with_index()

      right_value_graphemes =
        right_value
        |> String.graphemes()

      one_line_difference_accept =
        left_value_graphemes_with_index
        |> Enum.filter(fn {char, i} -> char != Enum.at(right_value_graphemes, i) end)

      smuges_count = length(one_line_difference_accept)

      if smuges_count <= 1 do
        explore(list, center_index, shift + 1, smuge_occurencies + smuges_count)
      else
        false
      end
    end
  end

  def extract_index_and_multiple(d, multiple) do
    if d != nil do
      {_, list} = d
      {_, mirror_index_start} = Enum.at(list, 0)

      (mirror_index_start + 1) * multiple
    else
      0
    end
  end

  def has_elements_with_index_one_after_another(list, el_i) do
    if length(list) == el_i + 1 do
      false
    else
      {_, curr_i} = Enum.at(list, el_i)
      {_, next_i} = Enum.at(list, el_i + 1)

      if curr_i + 1 == next_i do
        true
      else
        has_elements_with_index_one_after_another(list, el_i + 1)
      end
    end
  end
end
