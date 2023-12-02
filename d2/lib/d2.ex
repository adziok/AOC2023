defmodule D2 do
  def execute(inputPath, lapa) do
    File.read(inputPath)
    |> case do
      {:ok, content} -> content
      {:error, reason} -> raise reason
    end
    |> String.split("\n", trim: true)
    |> Enum.map(fn x -> GameParser.parse(x) end)
    |> Enum.filter(fn x ->
      x[:max_count][:red] <= lapa[:red] && x[:max_count][:blue] <= lapa[:blue] && x[:max_count][:green] <= lapa[:green]
    end)
    |> Enum.map(fn x -> x[:id] end)
    |> Enum.sum
  end


  def execute2(inputPath) do
    File.read(inputPath)
    |> case do
         {:ok, content} -> content
         {:error, reason} -> raise reason
       end
    |> String.split("\n", trim: true)
    |> Enum.map(fn x -> GameParser.parse(x) end)
    |> Enum.map(fn x ->
      x[:max_count][:red] * x[:max_count][:blue] * x[:max_count][:green]
    end)
    |> Enum.sum
  end
end
