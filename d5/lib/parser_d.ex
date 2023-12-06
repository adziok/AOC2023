defmodule ParserD do
  def execute2(mappings, type, ranges) do
    mapper = mappings[type]

    if(mapper != nil) do
      next_ranges =
        ranges
        |> Enum.map(fn range ->
          ParserC.parse_seeds(range, mapper)
        end)
        |> Enum.flat_map(fn x -> x end)

      execute2(mappings, mapper[:to], next_ranges)
    else
      # IO.inspect(type)
      # ranges
      # |> Enum.map(fn [a, b] -> [to_string(a), to_string(b)] end)
      # |> IO.inspect()
      ranges
    end
  end

  def execute(text) do
    [title | steps] =
      text
      |> String.split("\n\n", trim: true)
      |> Enum.map(fn raw_row ->
        raw_row
        |> String.split("\n", trim: true)
      end)
      |> Enum.map(fn el ->
        if(length(el) == 1) do
          List.first(el)
        else
          el
          |> Enum.map(fn e ->
            e
            |> String.replace(" map:", "")
          end)
        end
      end)

    seeds_ranges = ParserB.parse_seeds(title)

    mapper =
      steps
      |> Enum.map(fn step ->
        ParserA.parse_step(step)
      end)
      |> Map.new(fn [from, descr] -> {from, descr} end)

    d =
      execute2(mapper, "seed", seeds_ranges)

    e = d
    |> List.flatten()
    |> Enum.filter(fn e -> e < 58952912 end)
    |> Enum.filter(fn e -> e > 6577900 end)
    |> Enum.uniq()
    |> Enum.sort()

    IO.inspect(length(e))

    d
    |> List.flatten()
    |> Enum.min_by(fn dd -> dd end)

    # [seeds_ranges, mapper]
  end
end
