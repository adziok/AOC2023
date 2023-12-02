defmodule GameParserTest do
  use ExUnit.Case

  test "extractGameId" do
    assert GameParser.extractGameId("Game 1") == 1
    assert GameParser.extractGameId("Game 2") == 2
    assert GameParser.extractGameId("Game 3") == 3
    assert GameParser.extractGameId("Game 4") == 4
    assert GameParser.extractGameId("Game 5") == 5
  end

  test "extractRoundPoints" do
    assert GameParser.extractRoundPoints("3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green") == [
             %{blue: 3, red: 4},
             %{red: 1, green: 2, blue: 6},
             %{green: 2}
           ]
  end

  test "getMaxPointsPerColor" do
    assert GameParser.getMaxPointsPerColor([
             %{blue: 3, red: 4},
             %{red: 1, green: 2, blue: 6},
             %{green: 2}
           ]) == %{red: 4, green: 2, blue: 6}
  end

  test "simpleExample" do
    data = "Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green"

    assert GameParser.parse(data) == %{
             id: 1,
             max_count: %{
               blue: 6,
               red: 4,
               green: 2
             }
           }
  end
end
