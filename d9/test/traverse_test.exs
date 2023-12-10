defmodule TraverseTest do
  use ExUnit.Case

  test "part1 test" do
    assert Traverse.traverse([0, 3, 6, 9, 12, 15]) == %{
             :deep => 3,
             1 => [0, 3, 6, 9, 12, 15],
             2 => [3, 3, 3, 3, 3],
             3 => [0, 0, 0, 0]
           }
  end

  # test "part2 test" do
  #   assert Traverse.traverse([0, 3, 6, 9, 12, 15]) == %{
  #            layers: 3,
  #            "1": [0, 3, 6, 9, 12, 15],
  #            "2": [3, 3, 3, 3, 3],
  #            "3": [0, 0, 0, 0]
  #          }
  # end

  test "part3 test" do
    assert Traverse.traverse([1, 3, 6, 10, 15, 21]) == %{
             :deep => 4,
             1 => [1, 3, 6, 10, 15, 21],
             2 => [2, 3, 4, 5, 6],
             3 => [1, 1, 1, 1],
             4 => [0, 0, 0]
           }
  end
end
