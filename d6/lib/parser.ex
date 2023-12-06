defmodule Parser do
  def race(max_time, hold) do
    if(max_time ==  hold) do
      [0]
    else
      race_time = max_time - hold
      result = race_time * hold
      [result, race(max_time, hold + 1)]
    end
  end

  def parse(text) do
    text
    |> String.split("\n")
    |> Enum.map(fn s ->
      s
      |> String.split(" ", trim: true)
      |> Enum.map(fn n ->
        n
        |> Integer.parse()
        |> case do
          {num, ""} -> num
          :error -> nil
        end
      end)
      |> Enum.filter(fn x -> x != nil end)
    end)
    |> Enum.zip()
    |> Enum.map(fn {time, record} ->
      race(time, 0)
      |> List.flatten()
      |> Enum.filter(fn a -> a > record end)
      |> length()
    end)
    |> Enum.reduce(fn curr, acc -> acc * curr end)
  end

  def parse2(text) do
    text
    |> String.split("\n")
    |> Enum.map(fn s ->
      s
      |> String.split(":", trim: true)
      |> Enum.map(fn n ->
        n
        |> String.replace(" ", "")
        |> Integer.parse()
        |> case do
          {num, ""} -> num
          :error -> nil
        end
      end)
      |> Enum.filter(fn x -> x != nil end)
    end)
    |> Enum.zip()
    |> Enum.map(fn {time, record} ->
      race(time, 0)
      |> List.flatten()
      |> Enum.filter(fn a -> a > record end)
      |> length()
    end)
    |> Enum.reduce(fn curr, acc -> acc * curr end)
  end
end
