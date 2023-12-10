defmodule Parser do
  def parse(text) do
    text
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      line
      |> String.split(" ", trim: true)
    end)
    |> Enum.map(fn s_nums ->
      s_nums
      |> Enum.map(fn s_num ->
        s_num
        |> Integer.parse()
        |> case do
          {num, _res} -> num
        end
      end)
    end)
  end
end
