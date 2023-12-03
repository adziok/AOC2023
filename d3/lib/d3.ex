defmodule D3 do
  def execute(inputPath) do
    File.read(inputPath)
    |> case do
         {:ok, content} -> content
         {:error, reason} -> raise reason
       end
    |> Search.execute
    # |> IO.inspect(label: "Cho")
#    |> Enum.map(fn x -> GameParser.parse(x) end)
#    |> Enum.map(fn x ->
#      x[:max_count][:red] * x[:max_count][:blue] * x[:max_count][:green]
#    end)
#    |> Enum.sum
  end
end
