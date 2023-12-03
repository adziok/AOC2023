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

  def shouldBeCalculated2stars(values, curr) do
    curr[:type] == :Number &&
      (mget?(getByCord(values, curr[:x] - 1, curr[:y] - 1), :cho) == true ||
         mget?(getByCord(values, curr[:x] - 1, curr[:y]), :cho) == true ||
         mget?(getByCord(values, curr[:x] - 1, curr[:y] + 1), :cho) == true ||
         mget?(getByCord(values, curr[:x], curr[:y] - 1), :cho) == true ||
         mget?(getByCord(values, curr[:x], curr[:y] + 1), :cho) == true ||
         mget?(getByCord(values, curr[:x] + 1, curr[:y] - 1), :cho) == true ||
         mget?(getByCord(values, curr[:x] + 1, curr[:y]), :cho) == true ||
         mget?(getByCord(values, curr[:x] + 1, curr[:y] + 1), :cho) == true)
  end

  def getIds(values, curr) do
      [mget?(getByCord(values, curr[:x] - 1, curr[:y] - 1), :id),
         mget?(getByCord(values, curr[:x] - 1, curr[:y]), :id),
         mget?(getByCord(values, curr[:x] - 1, curr[:y] + 1), :id) ,
         mget?(getByCord(values, curr[:x], curr[:y] - 1), :id) ,
         mget?(getByCord(values, curr[:x], curr[:y] + 1), :id) ,
         mget?(getByCord(values, curr[:x] + 1, curr[:y] - 1), :id) ,
         mget?(getByCord(values, curr[:x] + 1, curr[:y]), :id) ,
         mget?(getByCord(values, curr[:x] + 1, curr[:y] + 1), :id)]
         |> Enum.filter(fn d -> d != false && d != nil end)
  end


  def countNumberConnections(values, curr) do
    left = case mget?(getByCord(values, curr[:x], curr[:y] - 1), :type) == :Number do
      true -> 1
      false -> 0
    end
    right = case mget?(getByCord(values, curr[:x], curr[:y] + 1), :type) == :Number do
      true -> 1
      false -> 0
    end

    top =
      case mget?(getByCord(values, curr[:x] + 1, curr[:y] - 1), :type) == :Number ||
             mget?(getByCord(values, curr[:x] + 1, curr[:y]), :type) == :Number ||
             mget?(getByCord(values, curr[:x] + 1, curr[:y] + 1), :type) == :Number do
        true -> cond do
          mget?(getByCord(values, curr[:x] + 1, curr[:y] - 1), :type) == :Number &&
          mget?(getByCord(values, curr[:x] + 1, curr[:y]), :type) != :Number &&
          mget?(getByCord(values, curr[:x] + 1, curr[:y] + 1), :type) == :Number -> 2
          true -> 1
        end
        false -> 0
      end

    bottom =
      case mget?(getByCord(values, curr[:x] - 1, curr[:y] - 1), :type) == :Number ||
             mget?(getByCord(values, curr[:x] - 1, curr[:y]), :type) == :Number ||
             mget?(getByCord(values, curr[:x] - 1, curr[:y] + 1), :type) == :Number do
        true -> cond do
          mget?(getByCord(values, curr[:x] - 1, curr[:y] - 1), :type) == :Number &&
          mget?(getByCord(values, curr[:x] - 1, curr[:y]), :type) != :Number &&
          mget?(getByCord(values, curr[:x] - 1, curr[:y] + 1), :type) == :Number -> 2
          true -> 1
        end
        false -> 0
      end

    left+right+bottom+top
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
    |> List.flatten()
    |> Enum.filter(fn v -> v[:type] == :Number && v[:dupa] == true end)
    |> Enum.reduce("", fn el, acc ->
      cond do
        el[:parentNumber] == false -> "#{acc},#{el[:value]}"
        true -> "#{acc}#{el[:value]}"
      end
    end)
    |> String.split(",")
    |> Enum.filter(fn v -> String.length(v) > 0 end)
    |> Enum.map(fn v -> Integer.parse(v) end)
    |> Enum.map(fn v ->
      v
      |> case do
        {num, ""} -> num
      end
    end)
    |> Enum.sum()
  end

  def execute2(input) do
    values = calculate(input)

    values_2 =
      values
      |> Enum.map(fn v1 ->
        v1
        |> Enum.map(fn curr ->
          if(curr[:value] == "*" && countNumberConnections(values, curr) == 2) do
            Map.merge(curr, %{cho: true, id: "#{inspect make_ref()}"  })
          else
            curr
          end
        end)
      end)

    values2 =
      values_2
      |> Enum.map(fn v1 ->
        v1
        |> Enum.map(fn v ->
          b = shouldBeCalculated2stars(values_2, v)
          ids = getIds(values_2, v)
          case b do
            true ->
              Map.merge(v, %{dupa: true, id: hd(ids)})
            false->
              Map.merge(v, %{dupa: false})
          end
        end)
      end)
      |> IO.inspect()

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
              Map.merge(curr, %{dupa: true, id: mget?(next, :id)})
            else
              if(mget?(prev, :dupa) == true) do
                Map.merge(curr, %{dupa: true , id: mget?(prev, :id)})
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
              Map.merge(curr, %{dupa: true, id: mget?(next, :id)})
            else
              if(mget?(prev, :dupa) == true) do
                Map.merge(curr, %{dupa: true , id: mget?(prev, :id)})
              else
                curr
              end
            end
          end
        end)
      end)

    values4
      |> List.flatten()
      |> Enum.filter(fn v -> v[:type] == :Number && v[:dupa] == true end)
      |> Enum.reduce("", fn el, acc ->
        cond do
          el[:parentNumber] == false -> "#{acc},[#{el[:id]}]:#{el[:value]}"
          true -> "#{acc}#{el[:value]}"
        end
      end)
      |> String.split(",")
      |> Enum.filter(fn v -> String.length(v) > 0 end)
      |> Enum.group_by(fn v -> hd(String.split(v, ":")) end, fn v -> List.last(String.split(v, ":")) end)
      |> IO.inspect()
      |> Map.values()
      |> Enum.map(fn v2 ->
        v2
        |> Enum.map(fn v -> Integer.parse(v) end)
        |> Enum.map(fn v ->
          v
          |> case do
            {num, ""} -> num
          end
        end)
        |> Enum.reduce(fn l, acc -> l*acc end)
      end)
      |> Enum.sum()
  end
end
