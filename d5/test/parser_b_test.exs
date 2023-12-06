defmodule ParserBTest do
  use ExUnit.Case

  test "parser only maped" do
    assert ParserB.parse_seeds("seeds: 79 14 55 13") ==
             [
               [55, 67],
               [79, 92]
             ]
  end

  test "pp" do
    assert ParserB.parse_seeds("seeds: 1778931867 1436999653 3684516104 2759374 1192793053 358764985 1698790056 76369598 3733854793 214008036 4054174000 171202266 3630057255 25954395 798587440 316327323 290129780 7039123 3334326492 246125391") ==
      []
  end
end
