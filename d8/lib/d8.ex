defmodule D8 do
  def part1(inputPath) do
    [steps, regions] =
      File.read(inputPath)
      |> case do
        {:ok, content} -> content
        {:error, reason} -> raise reason
      end
      |> Parser.parse()

    CountSteps.count(steps, regions, "AAA", "ZZZ")
  end

  def part2(inputPath) do
    [steps, regions] =
      File.read(inputPath)
      |> case do
        {:ok, content} -> content
        {:error, reason} -> raise reason
      end
      |> Parser.parse()

    start_regions =
      regions
      |> Map.to_list()
      |> Enum.filter(fn {name, _} ->
        String.at(name, 2) == "A"
      end)
      |> Enum.map(fn {name, _} -> name end)
      |> Enum.take(1)
      |> IO.inspect()

    end_regions = start_regions
      |> Enum.map(fn name -> String.slice(name, 0, 2) <> "Z" end)

    CountSteps.count_many(steps, regions, start_regions, end_regions)
  end
end
