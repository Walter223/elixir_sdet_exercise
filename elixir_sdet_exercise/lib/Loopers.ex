defmodule Loopers do
  use Hound.Helpers

  def check_for_element(path, times_to_check) when false or times_to_check > 0 do
    IO.puts element?(:xpath, "#{path}")
  end
    
  def check_for_element(path, times_to_check) do
    element?(:xpath, "#{path}")
    :timer.sleep(500)
    check_for_element(path, times_to_check - 1)
  end
end