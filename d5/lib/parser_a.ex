defmodule ParserA do
  def parse_title(title) do
    [from, to] = String.split(title, "-to-")

    {from, to}
  end

  def fill_gaps(ranges) do
    rr =
      ranges
      |> Enum.sort_by(fn e ->
        [dest, source, count] = e
        source
      end)
      |> Enum.with_index()
      |> Map.new(fn {v, k} -> {k, v} end)

    rr
    |> Enum.to_list()
    |> Enum.map(fn e ->
      {i, [dest, source, count]} = e
      a = source
      b = source + count - 1
      next_el = rr[i + 1]

      if(next_el != nil) do
        [next_dest, next_source, next_count] = next_el
        next_a = next_source
        next_b = next_source + next_count - 1

        cond do
          i == 0 && a != 0 && b + 1 == next_a ->
            [%{from: 0, to: a - 1, shift: 0}, %{from: a, to: b, shift: source - dest}]

          i == 0 && a != 0 ->
            [
              %{from: 0, to: a - 1, shift: 0},
              %{from: a, to: b, shift: source - dest},
              %{from: b + 1, to: next_a - 1, shift: next_source - next_dest}
            ]

          i == 0 && a == 0 && b + 1 == next_a ->
            [%{from: a, to: b, shift: source - dest}]

          i == 0 && a == 0 ->
            [
              %{from: a, to: b, shift: source - dest},
              %{from: b + 1, to: next_a - 1, shift: next_source - next_dest}
            ]

          b + 1 == next_a ->
            [%{from: a, to: b, shift: source - dest}]

          true ->
            [
              %{from: a, to: b, shift: source - dest},
              %{from: b + 1, to: next_a - 1, shift: next_source - next_dest}
            ]
        end
      else
        [
          %{from: a, to: b, shift: source - dest},
          %{from: b + 1, to: 999_000_000_000_000, shift: 0}
        ]
      end
    end)
    |> Enum.flat_map(fn x -> x end)
    |> Enum.with_index()
    |> Enum.map(fn {x, i} -> Map.merge(x, %{shift: x[:shift] * -1, id: i}) end)
  end

  def parse_step(values) do
    [title | ranges] = values
    {from, to} = parse_title(title)

    parsed_ranges =
      ranges
      |> Enum.map(fn e ->
        e
        |> String.split(" ")
        |> Enum.map(fn i ->
          i
          |> Integer.parse()
          |> case do
            {num, ""} -> num
          end
        end)
      end)

    [from, %{to: to, ranges: fill_gaps(parsed_ranges)}]
  end
end
