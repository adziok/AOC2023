defmodule RowParser do
  def parse_id(raw_id) do
    raw_id
    |> String.replace("Card ", "")
    |> String.replace(" ", "")
    |> Integer.parse()
    |> case do
      {num, _} -> num
    end
  end

  def parse_row(raw_row) do
    values = List.last(raw_row)
    |> String.split("|", trim: true)
    |> Enum.map(fn v ->
      v
      |> String.split(" ", trim: true)
      |> Enum.filter(fn s -> String.length(s) > 0 end)
      |> Enum.map(fn vs ->
        vs
        |> Integer.parse()
        |> case do
          {num, _} -> num
        end
      end)
    end)

    %{ id: parse_id(hd(raw_row)), choosen: List.last(values), winning: hd(values)}
  end

  def parse(raw_row) do
    raw_row
    |> String.split(":", trim: true)
    |> parse_row
  end
end
