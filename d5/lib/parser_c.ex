defmodule ParserC do
  def parse_seeds([min, max], step) do
    start_range_id =
      step[:ranges]
      |> Enum.find(fn range ->
        range[:from] <= min && range[:to] >= min
      end)
      |> Map.get(:id)

    end_range_id =
      step[:ranges]
      |> Enum.find(fn range ->
        range[:from] <= max && range[:to] >= max
      end)
      |> Map.get(:id)

    affected_ranges =
      start_range_id..end_range_id
      |> Enum.to_list()
      |> Enum.map(fn id ->
        step[:ranges]
        |> Enum.find(fn rng -> rng[:id] == id end)
      end)

    r =
      affected_ranges
      |> Enum.map(fn range ->
        cond do
          range[:id] == start_range_id && range[:id] == end_range_id ->
            [min + range[:shift], max + range[:shift]]

          range[:id] == start_range_id ->
            [min + range[:shift], range[:to] + range[:shift]]

          range[:id] == end_range_id ->
            [range[:from] + range[:shift], max + range[:shift]]

          range[:id] > start_range_id && range[:id] < end_range_id ->
            [range[:from] + range[:shift], range[:to] + range[:shift]]

          true ->
            nil
        end
      end)
      |> Enum.filter(fn a -> a != nil end)

    # r
    # |> Enum.map(fn [a,v] -> [to_string(a), to_string(v)] end)
    # |> IO.inspect()

    r
  end
end
