defmodule D3 do
  def execute(inputPath) do
    File.read(inputPath)
    |> case do
         {:ok, content} -> content
         {:error, reason} -> raise reason
       end
    |> Search.execute2
  end
end
