defmodule CalculateNextElementTest do
  use ExUnit.Case

  # test "part1 test" do
  #   assert CalculateNextElement.calc(%{
  #            1 => [0, 3, 6, 9, 12, 15],
  #            2 => [3, 3, 3, 3, 3],
  #            3 => [0, 0, 0, 0],
  #            :deep => 3
  #          }) == 18
  # end

  # test "part2 test" do
  #   assert CalculateNextElement.calc(%{
  #            1 => [1, 3, 6, 10, 15, 21],
  #            2 => [2, 3, 4, 5, 6],
  #            3 => [1, 1, 1, 1],
  #            4 => [0, 0, 0],
  #            :deep => 4
  #          }) == 28
  # end

  # test "part3 test" do
  #   assert CalculateNextElement.calc(%{
  #            1 => [10, 13, 16, 21, 30, 45],
  #            2 => [3, 3, 5, 9, 15],
  #            3 => [0, 2, 4, 6],
  #            4 => [2, 2, 2],
  #            5 => [0, 0],
  #            :deep => 5
  #          }) == 68
  # end

  test "part11 test" do
    assert CalculateNextElement.calc_prev(%{
             1 => [0, 3, 6, 9, 12, 15],
             2 => [3, 3, 3, 3, 3],
             3 => [0, 0, 0, 0],
             :deep => 3
           }) == -3
  end

  test "part21 test" do
    assert CalculateNextElement.calc_prev(%{
             1 => [1, 3, 6, 10, 15, 21],
             2 => [2, 3, 4, 5, 6],
             3 => [1, 1, 1, 1],
             4 => [0, 0, 0],
             :deep => 4
           }) == 0
  end

  test "part31 test" do
    assert CalculateNextElement.calc_prev(%{
             1 => [10, 13, 16, 21, 30, 45],
             2 => [3, 3, 5, 9, 15],
             3 => [0, 2, 4, 6],
             4 => [2, 2, 2],
             5 => [0, 0],
             :deep => 5
           }) == 5
  end
end
