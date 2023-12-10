defmodule D9 do
  def part1(inputPath) do
    File.read(inputPath)
    |> case do
      {:ok, content} -> content
      {:error, reason} -> raise reason
    end
    |> Parser.parse()
    |> Enum.map(fn e -> Traverse.traverse(e) end)
    |> Enum.map(fn e -> CalculateNextElement.calc(e) end)
    |> Enum.sum()
  end

  def part2(inputPath) do
    File.read(inputPath)
    |> case do
      {:ok, content} -> content
      {:error, reason} -> raise reason
    end
    |> Parser.parse()
    |> Enum.map(fn e -> Traverse.traverse(e) end)
    |> Enum.map(fn e -> CalculateNextElement.calc_prev(e) end)
    |> Enum.sum()
  end
end
