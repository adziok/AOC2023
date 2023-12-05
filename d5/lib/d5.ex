defmodule D5 do
  def part1(inputPath) do
    File.read(inputPath)
    |> case do
      {:ok, content} -> content
      {:error, reason} -> raise reason
    end
    |> Parser.parse
  end
end
