defmodule Parser do
  def extract_variables(text) do
    pattern = ~r/(\w+) = \((\w+), (\w+)\)/

    case Regex.match?(pattern, text) do
      true ->
        [_, variable1, variable2, variable3] = Regex.run(pattern, text)
        {variable1, %{name: variable1, L: variable2, R: variable3}}

      false ->
        IO.puts("No match found.")
    end
  end

  def parse(text) do
    [moves | regions] =
      text
      |> String.split("\n\n", trim: true)

    parsed =
      hd(regions)
      |> String.split("\n", trim: true)
      # |> IO.inspect()
      |> Enum.map(fn line -> extract_variables(line) end)
      |> Map.new()

    [
      moves
      |> String.graphemes(),
      parsed
    ]
  end
end
