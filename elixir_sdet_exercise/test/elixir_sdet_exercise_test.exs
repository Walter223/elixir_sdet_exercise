defmodule ElixirSdetExerciseTest do
  # Import helpers
  use Hound.Helpers
  use ExUnit.Case

  # Start hound session and destroy when tests are run
  hound_session()

  # test "goes to google" do
  #   navigate_to "http://google.com"
  #   IO.inspect page_title() ; :timer.sleep(3000)
    
  # end

  # test "goes to facebook" do 
  #   navigate_to "https://facebook.com"
  #   IO.inspect page_title() ; :timer.sleep(5000)
  # end

  test "goes to facebook and enters an email" do
    navigate_to "https://facebook.com"
    email = find_element(:id, "email")
    click(email)
    IO.puts current_url()
    send_text("thisisanemail@gmail.com")
    :timer.sleep(1000)
    take_screenshot("test/screenshots/first_fb_test.png")
  end
end
