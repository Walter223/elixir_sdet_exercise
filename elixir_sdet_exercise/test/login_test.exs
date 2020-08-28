defmodule LoginTest do
  # Import helpers
  require Helpers
  require Loopers
  use Hound.Helpers
  use ExUnit.Case
  

  # Start hound session and destroy when tests are run
  hound_session()
  
  setup_all do
    #Clear previous screenshots
    File.rm_rf("test/screenshots/.")
    :ok
  end

  @tag :login_test
  test "Failed login attempts go to new page" do
    maximize_window(current_window_handle())
    navigate_to "https://facebook.com"
    unless element?(:link_text, "Create New Account") do
      navigate_to "https://facebook.com"
    end
    Loopers.check_for_element(".//button[text()='Log In']", 4)
    assert element?(:link_text, "Create New Account")
    assert page_title() == "Facebook - Log In or Sign Up"
    assert current_path() == "/"
    assert current_url() == "https://www.facebook.com/"
    Helpers.fill_out_login_email "travisbigelowtest@gmail.com"
    Helpers.fill_out_login_pass "thisiswrong"
    Loopers.click_until(".//button[@name='login']", ".//a[@text()='Forgot Password?']", 2)
    assert page_title() == "Log into Facebook | Facebook"
    assert Regex.match?(~r/login/, current_path())
    Regex.match?(~r"https://www.facebook.com/login/", current_url())
  end
end