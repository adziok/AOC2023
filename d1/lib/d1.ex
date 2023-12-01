defmodule D1 do
  @moduledoc """
  Documentation for `D1`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> D1.hello()
      :world

  """
  def hello do
    :world
  end

  def doit do
    File.read("./input/input.txt")
    |> case do
      {:ok, content} -> content
      {:error, reason} -> raise reason
    end
    |> String.split("\n")
    |> Enum.filter(fn x -> String.length(x) > 0 end)
    |> Enum.map(fn x -> ElvesStringParser.extractNumbers(x) end)
    |> Enum.sum
  end
end
