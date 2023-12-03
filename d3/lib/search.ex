defmodule Search do
  def parseValue(v) do
    case Integer.parse(v) do
      {_num, _r} ->
        :Number

      :error ->
        case v do
          "." -> :Ignore
          _ -> :Trigger
        end
    end
  end

  def getByCord(values, x, y) do
    values
    |> Enum.at(x)
    |> case do
      nil -> nil
      v -> v |> Enum.at(y)
    end
  end

  def mget?(value, key) do
    case value do
      nil -> nil
      _ -> Map.has_key?(value, key) && Map.get(value, key)
    end
  end


  def shouldBeCalculated(values, curr) do
    curr[:type] == :Number &&
      (mget?(getByCord(values, curr[:x] - 1, curr[:y] - 1), :type) == :Trigger ||
         mget?(getByCord(values, curr[:x] - 1, curr[:y]), :type) == :Trigger ||
         mget?(getByCord(values, curr[:x] - 1, curr[:y] + 1), :type) == :Trigger ||
         mget?(getByCord(values, curr[:x], curr[:y] - 1), :type) == :Trigger ||
         mget?(getByCord(values, curr[:x], curr[:y] + 1), :type) == :Trigger ||
         mget?(getByCord(values, curr[:x] + 1, curr[:y] - 1), :type) == :Trigger ||
         mget?(getByCord(values, curr[:x] + 1, curr[:y]), :type) == :Trigger ||
         mget?(getByCord(values, curr[:x] + 1, curr[:y] + 1), :type) == :Trigger)
  end

  def calculate(input) do
    inp =
      input
      |> String.split("\n", trim: true)
      |> Enum.map(fn x ->
        x
        |> String.graphemes()
      end)

    rows_len = length(inp |> Enum.at(0)) - 1
    rows_count = length(inp) - 1

    for row_i <- 0..rows_count do
      for col_i <- 0..rows_len do
        curr = inp |> Enum.at(row_i) |> Enum.at(col_i)
        type = parseValue(curr)

        parentNumber =
          cond do
            type == :Number && col_i - 1 >= 0 ->
              prev = inp |> Enum.at(row_i) |> Enum.at(col_i - 1)
              type = parseValue(prev)

              cond do
                type == :Number ->
                  %{x: row_i, y: col_i - 1}

                true ->
                  false
              end

            true ->
              false
          end

        %{x: row_i, y: col_i, value: curr, type: type, parentNumber: parentNumber}
      end
    end
  end

  def execute(input) do
    values = calculate(input)

    values2 =
      values
      |> Enum.map(fn v1 ->
        v1
        |> Enum.map(fn v ->
          b = shouldBeCalculated(values, v)

          Map.merge(v, %{dupa: b})
        end)
      end)

    values3 =
    values2
    |> Enum.map(fn v1 ->
      v1
      |> Enum.map(fn curr ->
        next = getByCord(values2, curr[:x], curr[:y] + 1)
        prev = getByCord(values2, curr[:x], curr[:y] - 1)

        if(curr[:type] != :Number) do
          curr
        else
          if(mget?(next, :dupa) == true) do
            Map.merge(curr, %{dupa: true})
          else
            if(mget?(prev, :dupa) == true) do
              Map.merge(curr, %{dupa: true})
            else
              curr
            end
          end
        end
      end)
    end)

    values4 =
      values3
      |> Enum.map(fn v1 ->
        v1
        |> Enum.map(fn curr ->
          next = getByCord(values3, curr[:x], curr[:y] + 1)
          prev = getByCord(values3, curr[:x], curr[:y] - 1)

          if(curr[:type] != :Number) do
            curr
          else
            if(mget?(next, :dupa) == true) do
              Map.merge(curr, %{dupa: true})
            else
              if(mget?(prev, :dupa) == true) do
                Map.merge(curr, %{dupa: true})
              else
                curr
              end
            end
          end
        end)
      end)

    values4
    |> List.flatten
    |> Enum.filter(fn v -> v[:type] == :Number && v[:dupa] == true end)
    |> Enum.reduce("", fn el, acc ->
      cond do
        el[:parentNumber] == false ->  "#{acc},#{el[:value]}"
        true ->  "#{acc}#{el[:value]}"
      end
    end)
    |> String.split(",")
    |> Enum.filter(fn v -> String.length(v) > 0 end)
    |> Enum.map(fn v -> Integer.parse(v) end)
    |> Enum.map(fn v ->
      v |> case do
        {num, ""} -> num
      end
     end)
    |> Enum.sum
  end
end

# %{type: :Number, value: "3", y: 2, x: 0, parentNumber: %{y: 1, x: 0}}
