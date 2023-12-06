defmodule ParserB do
  def parse_seeds(text) do
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

    seed_numbers_base_ranges =
      seed_numbers
      |> Enum.map(fn i ->
        i
        |> Integer.parse()
        |> case do
          {num, ""} -> num
        end
      end)
      |> Enum.chunk_every(2)
      |> Enum.sort_by(fn e -> hd(e) end)
      |> Enum.map(fn e ->
        [a, b] = e
        [a, a + b - 1]
      end)
  end
end
