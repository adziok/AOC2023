defmodule Parser do

  def parse(text) do
    text
    |> String.split("\n\n", trim: true)
    |> IO.inspect()
  end
end
