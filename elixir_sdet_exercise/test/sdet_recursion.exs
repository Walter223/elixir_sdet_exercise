defmodule SdetRecursion do
  use Hound.Helpers

  def check_for_element(path, times_to_check) do
    IO.puts element?(:xpath, "#{path}")
  end
    
  def check_for_element(path, times_to_check) do
    IO.puts element?(:xpath, "#{path}")
    :timer.sleep(500)
    check_for_element(path, times_to_check - 1)
  end
end