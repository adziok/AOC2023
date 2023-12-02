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
      "nine" => "9"
    }

    values
  end

  defp replaceStringNumbersNamesToNumbers(text) do
    case String.length(text) > 0 do
      true ->
        replacedStringToNumberIfExists =
          Enum.reduce(stringNumberToNumber(), text, fn {pattern, replacement}, acc ->
            String.replace(acc, ~r/^#{pattern}/, replacement)
          end)

        result = replaceStringNumbersNamesToNumbers(String.slice(text, 1, 1000))

        [String.first(replacedStringToNumberIfExists), result]
        |> Enum.join()

      _ ->
        ""
    end
  end

  defp getTailAndHeadAndJoin(list) do
    [hd(list), List.last(list)]
    |> Enum.join()
  end

  def extractNumbers(lineOfText) do
    replaceStringNumbersNamesToNumbers(lineOfText)
    |> String.graphemes()
    |> Enum.filter(fn x ->
      case Integer.parse(x) do
        {_, ""} ->
          true

        _ ->
          false
      end
    end)
    |> Enum.to_list()
    |> getTailAndHeadAndJoin
    |> Integer.parse()
    |> case do
      {num, ""} -> num
    end
  end
end
