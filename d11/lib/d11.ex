defmodule D11 do
  def part1(inputPath) do
    File.read(inputPath)
    |> case do
      {:ok, content} -> content
      {:error, reason} -> raise reason
    end
    |> Parser.parse(2)
    |> PathLenghtFinder.find()
  end

  def part2(inputPath, divider, multipler) do
    File.read(inputPath)
    |> case do
      {:ok, content} -> content
      {:error, reason} -> raise reason
    end
    |> Parser.parse(divider)
    |> PathLenghtFinder.find(divider, multipler)
  end
end
