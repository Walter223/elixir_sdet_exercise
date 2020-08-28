defmodule Loopers do
  use Hound.Helpers

  def check_for_element(path, times_to_check) when times_to_check > 0 do
    element?(:xpath, "#{path}")
    :timer.sleep(500)
  end
    
  def check_for_element(path, times_to_check) do
    element?(:xpath, "#{path}")
    check_for_element(path, times_to_check - 1)
  end

  def click_until(element_to_click, element_to_check_for, times) when false or times > 0 do
    click(find_element(:xpath, "#{element_to_click}"))
    element?(:xpath, "#{element_to_check_for}")
    :timer.sleep(1000)
  end

  def click_until(element_to_click, element_to_check_for, times) do
    IO.puts element?(:xpath, "#{element_to_check_for}")
    click_until(element_to_click, element_to_check_for, times - 1)
  end
end