defmodule CobinationCalculatorTest do
  use ExUnit.Case
  doctest D12

  test "P1 1" do
    assert CobinationCalculator.calculate(%{text: "???.###", groups: [1, 1, 3]}) == 1
  end
end
