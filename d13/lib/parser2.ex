defmodule Parser2 do
  def transpose([[] | _]), do: []

  def transpose(m) do
    Enum.zip(m) |> Enum.map(&Tuple.to_list/1)
  end

  def eee2(list) do
    list
    |> Enum.map(fn list ->
      if(rem(length(list), 2) == 1) do
        1..length(list)-1
        |> Enum.map(fn e -> explore(list, e-1, 0) end)
        |> List.flatten()
        |> Enum.filter(fn e -> e != false end)
      else
        1..length(list)-1
        |> Enum.map(fn e -> explore(list, e-1, 0) end)
        |> Enum.filter(fn e -> e != false end)
        # explore(list, m - 1, 0)
      end
    end)
    |> List.flatten()
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
      |> Enum.map(fn d ->
        (d + 1) * 100
      end)
      |> Enum.sum()

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
      end)
      |> eee2()
      |> Enum.map(fn d ->
        (d + 1)
      end)
      |> Enum.sum()

    horizontal_mir + vertical_mir
  end

  def explore(list, center_index, shift) do
    is_odd = rem(length(list), 2) == 0

    odd_true_case = is_odd && (center_index - shift < 0 || center_index + shift + 1 >= length(list))

    nodd_true_case =
      !is_odd && (center_index - shift < 0 || center_index + shift + 1 == length(list))

    if odd_true_case || nodd_true_case do
      center_index
    else
      {left_value, li} = Enum.at(list, center_index - shift)
      {right_value, ri} = Enum.at(list, center_index + shift + 1)

      if left_value == right_value do
        explore(list, center_index, shift + 1)
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
