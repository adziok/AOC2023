defmodule ElvesStringParserTest do
  use ExUnit.Case
  # doctest ElvesStringParserTest 

  test "greets the world" do
    assert ElvesStringParser.extractNumbers("1asdsad13") == 13
    assert ElvesStringParser.extractNumbers("onetwo34five") == 15
    assert ElvesStringParser.extractNumbers("two1nine") == 29
    assert ElvesStringParser.extractNumbers("eightwothree") == 83
    assert ElvesStringParser.extractNumbers("abcone2threexyz") == 13
    assert ElvesStringParser.extractNumbers("xtwone3four") == 24
    assert ElvesStringParser.extractNumbers("4nineeightseven2") == 42
    assert ElvesStringParser.extractNumbers("zoneight234") == 14
    assert ElvesStringParser.extractNumbers("7pqrstsixteen") == 76
  end
end