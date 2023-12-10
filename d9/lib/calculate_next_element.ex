defmodule CalculateNextElement do
  def visit_element(elements, curr_index, prev_result) do
    if(curr_index == 0) do
      prev_result
    else
      res = prev_result + List.last(elements[curr_index])
      visit_element(elements, curr_index - 1, res)
    end
  end

  def calc(input) do
    visit_element(input, input[:deep] - 1, 0)
  end

  def visit_element_prev(elements, curr_index, prev_result) do
    if(curr_index == 0) do
      prev_result
    else
      res = List.first(elements[curr_index]) - prev_result
      visit_element_prev(elements, curr_index - 1, res)
    end
  end

  def calc_prev(input) do
    visit_element_prev(input, input[:deep] - 1, 0)
  end
end
