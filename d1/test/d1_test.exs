defmodule D1Test do
  use ExUnit.Case
  test "greets the world" do
    assert D1.doit() == 56017
  end

  test "bedziedobrze" do
    x = [
      "two1nine",
      "eightwothree",
      "abcone2threexyz",
      "xtwone3four",
      "4nineeightseven2",
      "zoneight234",
      "7pqrstsixteen"
    ]

    assert x
           |> Enum.map(fn x -> ElvesStringParser.extractNumbers(x) end)
           |> Enum.sum() == 281
  end
end
