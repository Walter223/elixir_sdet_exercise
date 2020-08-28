defmodule Loopers do
  use Hound.Helpers

  def check_for_element(path, times_to_check) do
    if times_to_check > 0 and element_displayed?(find_element(:xpath, "#{path}")) == false do
      :timer.sleep(500)
      new_count = times_to_check - 1
      check_for_element(path, new_count)
    end
    :ok
  end

  

  # def click_until(element_to_click, element_to_check_for, times) when false or times > 0 do
  #   click(find_element(:xpath, "#{element_to_click}"))
  #   element?(:xpath, "#{element_to_check_for}")
  # end

  def click_until(element_to_click, element_to_check_for, times) do
    if times > 0 and element?(:xpath, "#{element_to_check_for}") == false do
      click(find_element(:xpath, "#{element_to_click}"))
      count = times - 1
      :timer.sleep(100)
      click_until(element_to_click, element_to_check_for, count)
    end
  end
end