defmodule D10 do
  def part1(inputPath) do
    res = File.read(inputPath)
    |> case do
      {:ok, content} -> content
      {:error, reason} -> raise reason
    end
    |> Parser.parse()
    |> Traverser.traverse()

    floor(res / 2) + 1
  end

  def part2(inputPath) do
    File.read(inputPath)
    |> case do
      {:ok, content} -> content
      {:error, reason} -> raise reason
    end
  end
end
