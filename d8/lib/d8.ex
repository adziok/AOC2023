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

    d = regions
    |> Map.to_list()
    |> Enum.filter(fn {name, _} ->
      String.at(name, 2) == "A"
    end)
    |> Enum.map(fn {name, _} -> [name, String.slice(name, 0, 2) <> "Z"] end)
    |> Enum.map(fn [a,b] -> CountSteps.count_f(steps, regions, a, b) end)
    |> calculate_lcm()
  end

  def calculate_lcm(numbers) do
    numbers
    |> Enum.reduce(1, &lcm/2)
  end

  defp lcm(a, b) do
    div(a * b, gcd(a, b))
  end

  def gcd(x, 0), do: x
  def gcd(x, y), do: gcd(y, rem(x, y))
end
