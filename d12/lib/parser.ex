defmodule Parser do
  def parse(text) do
    text
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      [text, groups] =
        line
        |> String.split(" ", trim: true)

      parsed =
        groups
        |> String.split(",")
        |> Enum.map(fn i ->
          case Integer.parse(i) do
            {int, _} -> int
            :error -> raise "Bad int"
          end
        end)

      %{text: text, groups: parsed}
    end)
  end
end
