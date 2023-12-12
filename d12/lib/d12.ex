defmodule D12 do
  def part1(inputPath) do
    File.read(inputPath)
    |> case do
      {:ok, content} -> content
      {:error, reason} -> raise reason
    end
    |> Parser.parse()

    # |> PathLenghtFinder.find()
  end

  def part2(inputPath) do
    File.read(inputPath)
    |> case do
      {:ok, content} -> content
      {:error, reason} -> raise reason
    end
    |> Parser.parse()

    # |> PathLenghtFinder.find(divider, multipler)
  end
end
