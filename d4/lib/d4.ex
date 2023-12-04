defmodule D4 do
  def list_n_length(n) do
    String.duplicate("1", n)
    |> String.split("", trim: true)
    |> Enum.map(fn n -> String.to_integer(n) end)
  end

  def part1(inputPath) do
    File.read(inputPath)
    |> case do
      {:ok, content} -> content
      {:error, reason} -> raise reason
    end
    |> String.split("\n", trim: true)
    |> Enum.map(fn x -> RowParser.parse(x) end)
    |> Enum.map(fn x ->
      length(
        x[:choosen]
        |> Enum.filter(fn el ->
          Enum.member?(x[:winning], el)
        end)
      )
    end)
    |> Enum.map(fn e ->
      list = list_n_length(e)

      cond do
        length(list) > 0 -> list |> Enum.reduce(fn _e, acc -> acc * 2 end)
        true -> 0
      end
    end)
    |> Enum.sum()
  end

  def part2(inputPath) do
    File.read(inputPath)
    |> case do
      {:ok, content} -> content
      {:error, reason} -> raise reason
    end
    |> String.split("\n", trim: true)
    |> Enum.map(fn x -> RowParser.parse(x) end)
    |> Enum.map(fn x ->
      matchingElements =
        x[:choosen]
        |> Enum.filter(fn el ->
          Enum.member?(x[:winning], el)
        end)

      Map.merge(x, %{
        matchingElementsCount: length(matchingElements),
        matchingElements: matchingElements
      })
    end)
    |> CountCardsRec.execute()
  end
end
