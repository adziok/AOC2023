defmodule Parser do

  #["temperature-to-humidity", "3056037605 2829211160 523334807"]
  def get_value(values, index) do
    [h | ranges] = values

    range = ranges
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
      [id, eid, count] = e
      eid <= index && eid + count - 1 >= index
    end)

    if(hd(range) == nil) do
      index
    else
      [eid, id, count] = hd(range)
      move_count = index - id
      eid + move_count
    end
  end

  # ["seed-to-soil", "50 98 2", "52 50 48"] => ${1=>2, 3=>5}
  def map_parser2(values) do
    [h | ranges] = values

    defined_ranges = ranges
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
    |> Enum.map(fn e ->
      [id, eid, count] = e

      0..count
      |> Enum.map(fn a ->
        {eid + a, id + a}
      end)
    end)
    |> List.flatten()
    |> Map.new
  end

  # ["seed-to-soil", "50 98 2", "52 50 48"] => ["seed-to-soil", {1,1}, {2,2}]
  def map_parser(values, max_value) do
    [h | ranges] = values

    defined_ranges = ranges
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
    |> Enum.map(fn e ->
      [id, eid, count] = e

      0..count
      |> Enum.map(fn a ->
        {id + a, eid + a }
      end)
    end)
    |> List.flatten()
    |> Map.new

    l = 0..max_value
    |> Enum.map(fn i ->
      if(defined_ranges[i] != nil) do
        {i,defined_ranges[i]}
      else
        {i,i}
      end
    end)
    [h] ++ l
  end

  def execute(mappings, type, prev_value) do
    mapper = mappings[type]

    if(mapper != nil) do
      execute(mappings, mapper[:to], mapper[:mappings][prev_value] || prev_value)
    else
      prev_value
    end
  end

  def parse(text) do
    preprocessed_text = text
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


    [seeds | maps] =
    preprocessed_text

    [h |seed_numbers]=
      hd(preprocessed_text)

    n_seed_numbers = seed_numbers
    |> Enum.map(fn i ->
      i
      |> Integer.parse()
      |> case do
        {num, ""} -> num
      end
    end)

    get_value(hd(maps), 99)
    |> IO.inspect()


    mappers =
      maps
      |> Enum.map(fn map ->
        [title| mappings] = map
        [String.split(title, "-to-"), map_parser2(map)]
        |> List.flatten()
      end)
      |> Enum.map(fn m ->
        [from, to, mappings] = m
        {from, %{to: to, mappings: mappings }}
      end)
      |> Map.new

    n_seed_numbers
    |> Enum.map(fn e ->
      execute(mappers, "seed", e)
    end)
    |> List.flatten()
    # |> Enum.min_by(fn e -> e end)

  end
end
