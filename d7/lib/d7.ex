defmodule D7 do
  def part1(inputPath) do
    File.read(inputPath)
    |> case do
      {:ok, content} -> content
      {:error, reason} -> raise reason
    end
    |> Parser.parse()
    |> Enum.map(fn e ->
      HandCalculator.calculate(e)
    end)
    |> Enum.sort_by(fn e ->
      {
        e[:type_strength],
        Enum.at(e[:cards], 0)[:card_value],
        Enum.at(e[:cards], 1)[:card_value],
        Enum.at(e[:cards], 2)[:card_value],
        Enum.at(e[:cards], 3)[:card_value],
        Enum.at(e[:cards], 4)[:card_value]
      }
    end)
    |> Enum.with_index()
    |> Enum.map(fn {obj, index} -> Map.merge(obj, %{index: index + 1}) end)
    |> Enum.map(fn obj -> obj[:points] * obj[:index] end)
    |> Enum.sum()
  end

  def part2(inputPath) do
    File.read(inputPath)
    |> case do
      {:ok, content} -> content
      {:error, reason} -> raise reason
    end
    |> Parser.parse_j()
    |> Enum.map(fn e ->
      HandCalculator.calculate_j(e)
    end)
    |> Enum.sort_by(fn e ->
      {
        e[:type_strength],
        Enum.at(e[:cards], 0)[:card_value],
        Enum.at(e[:cards], 1)[:card_value],
        Enum.at(e[:cards], 2)[:card_value],
        Enum.at(e[:cards], 3)[:card_value],
        Enum.at(e[:cards], 4)[:card_value]
      }
    end)
    |> Enum.with_index()
    |> Enum.map(fn {obj, index} -> Map.merge(obj, %{index: index + 1}) end)
    |> Enum.map(fn obj -> obj[:points] * obj[:index] end)
    |> Enum.sum()
  end
end
