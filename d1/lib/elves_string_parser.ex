defmodule ElvesStringParser do
  def stringNumberToNumber() do
    values = %{
      "one" => "1",
      "two" => "2",
      "three" => "3",
      "four" => "4",
      "five" => "5",
      "six" => "6",
      "seven" => "7",
      "eight" => "8",
      "nine" => "9",
    }

    values
  end
  # 1twone
  defp testReplaceIncremental(text) do
    String.
  end

  defp getTailAndHeadAndJoin(list) do
    [hd(list), List.last(list)] 
    |> Enum.join
  end

  defp replaceStringNumbersNamesToNumbers(text) do
    Enum.reduce(stringNumberToNumber(), text, fn {pattern, replacement}, acc ->
      String.replace(acc, ~r/#{pattern}/, replacement)
    end)
  end

  def extractNumbers(lineOfText) do 
    replaceStringNumbersNamesToNumbers(lineOfText)
    |> IO.inspect
    |> String.graphemes() 
    |> Enum.filter(fn x -> 
      case Integer.parse(x) do
        {_, ""} ->
          true
        _ ->
          false
        end
      end
    )
    |> Enum.to_list
    |> getTailAndHeadAndJoin
    |> Integer.parse
    |> case do
        {num,""} -> num 
      end
  end
end
