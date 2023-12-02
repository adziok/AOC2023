defmodule GameParser do
  def extractGameId(game) do
    game
    |> String.split(" ", trim: true)
    |> List.last()
    |> String.to_integer()
  end

  def extractRoundPoints(round) do
    round
    |> String.split(";", trim: true)
    |> Enum.map(fn x -> String.trim(x) end)
    |> Enum.map(fn x -> String.split(x, ",", trim: true) end)
    |> Enum.map(fn x -> Enum.map(x, fn y -> String.trim(y) end) end)
    |> Enum.map(fn x -> Enum.map(x, fn y -> String.split(y, " ", trim: true) end) end)
    |> Enum.map(fn x ->
      Enum.map(x, fn y -> {String.to_atom(Enum.at(y, 1)), String.to_integer(hd(y))} end)
    end)
    |> Enum.map(fn x -> Enum.into(x, %{}) end)
  end

  def getMaxPointsPerColor(rounds) do
    [:green, :red, :blue]
    |> Enum.map(fn x -> {x, Enum.map(rounds, fn y -> Map.get(y, x, 0) end) |> Enum.max()} end)
    |> Enum.into(%{})
  end

  defp parseRecord(list) do
    %{
      id: extractGameId(List.first(list)),
      max_count: getMaxPointsPerColor(extractRoundPoints(List.last(list)))
    }
  end

  def parse(record) do
    record
    |> String.split(": ", trim: true)
    |> Enum.to_list()
    |> parseRecord
  end
end
