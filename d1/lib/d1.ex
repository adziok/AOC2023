defmodule D1 do
  def doit do
    File.read("./input/input2.txt")
    |> case do
      {:ok, content} -> content
      {:error, reason} -> raise reason
    end
    |> String.split("\n", trim: true)
    |> Enum.map(fn x -> ElvesStringParser.extractNumbers(x) end)
    |> Enum.sum()
  end
end
