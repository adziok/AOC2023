defmodule Parser do
  def get_value(ranges, index) do
    range =
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
      |> Enum.filter(fn e ->
        [_id, eid, count] = e
        eid <= index && eid + count - 1 >= index
      end)

    if(length(range) == 0 || hd(range) == nil) do
      index
    else
      [eid, id, _count] = hd(range)
      move_count = index - id
      eid + move_count
    end
  end

  def execute(mappings, type, prev_value) do
    mapper = mappings[type]

    if(mapper[:mappings] != nil) do
      execute(mappings, mapper[:to], get_value(mapper[:mappings], prev_value))
    else
      prev_value
    end
  end

  def parse(text) do
    preprocessed_seeds_numbers =
      hd(
        text
        |> String.split("\n\n", trim: true)
      )

    [_h | seed_numbers] =
      String.split(preprocessed_seeds_numbers, "\n", trim: true)
      |> Enum.map(fn el ->
        el
        |> String.split(":", trim: true)
        |> Enum.map(fn e ->
          e
          |> String.split(" ", trim: true)
        end)
      end)
      |> List.flatten()

    n_seed_numbers =
      seed_numbers
      |> Enum.map(fn i ->
        i
        |> Integer.parse()
        |> case do
          {num, ""} -> num
        end
      end)

    parse_impl(text, n_seed_numbers)
  end

  def parse_impl(text, n_seed_numbers) do
    preprocessed_text =
      text
      |> String.split("\n\n", trim: true)
      |> Enum.map(fn raw_row ->
        raw_row
        |> String.split("\n", trim: true)
      end)
      |> Enum.map(fn el ->
        if(length(el) == 1) do
          List.first(el)
          |> String.split(":", trim: true)
          |> Enum.map(fn e ->
            e
            |> String.split(" ", trim: true)
          end)
          |> List.flatten()
        else
          el
          |> Enum.map(fn e ->
            e
            |> String.replace(" map:", "")
          end)
        end
      end)

    [_seeds | maps] =
      preprocessed_text

    mappers =
      maps
      |> Enum.map(fn map ->
        [title | mappings] = map

        [String.split(title, "-to-"), mappings]
        |> List.flatten()
      end)
      |> Enum.map(fn m ->
        [from, to | mappings] = m
        {from, %{to: to, mappings: mappings}}
      end)
      |> Map.new()

    n_seed_numbers
    |> Enum.map(fn e ->
      execute(mappers, "seed", e)
    end)
    |> List.flatten()
    |> Enum.min_by(fn e -> e end)
  end

  def parse_range(text) do
    preprocessed_seeds_numbers =
      hd(
        text
        |> String.split("\n\n", trim: true)
      )

    [_h | seed_numbers] =
      String.split(preprocessed_seeds_numbers, "\n", trim: true)
      |> Enum.map(fn el ->
        el
        |> String.split(":", trim: true)
        |> Enum.map(fn e ->
          e
          |> String.split(" ", trim: true)
        end)
      end)
      |> List.flatten()

    n_seed_numbers =
      seed_numbers
      |> Enum.map(fn i ->
        i
        |> Integer.parse()
        |> case do
          {num, ""} -> num
        end
      end)
      |> Enum.chunk_every(2)
      |> Enum.map(fn e ->
        [start, count] = e
        start..start+count
      end)
      |> IO.inspect()
      |> Enum.map(fn e ->
        IO.inspect(e)
        parse_impl(text, e)
      end)
      |> List.flatten()
      # |> IO.inspect()

    # IO.inspect(n_seed_number)
  end
end
