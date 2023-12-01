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
    assert ElvesStringParser.extractNumbers("one") == 11
    assert ElvesStringParser.extractNumbers("zone") == 11
    assert ElvesStringParser.extractNumbers("oone") == 11
    assert ElvesStringParser.extractNumbers("twone") == 22
  end
end
