defmodule ElixirSdetExerciseTest do
  # Import helpers
  use Hound.Helpers
  use ExUnit.Case
  import SdetRecursion

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

  # test "goes to facebook and enters an email and password" do
  #   navigate_to "https://facebook.com"
  #   email = find_element(:id, "email")
  #   click(email)
  #   send_text("thisisanemail@gmail.com")
  #   password = find_element(:id, "pass")
  #   click(password)
  #   send_text("password123")
  #   take_screenshot("test/screenshots/#{DateTime.utc_now()}.png")
  # end

  # test "Click the Create New Account Button" do
  #   navigate_to "https://facebook.com"
  #   create_account_btn = find_element(:link_text, "Create New Account")
  #   click(create_account_btn)
  #   :timer.sleep(1000)
  #   # IO.inspect page_title()
  #   IO.puts element?(:xpath, ".//div[text()='Sign Up']")
  # end

  test "Invalid Name Message Appears With Bad Data" do
    navigate_to "https://facebook.com"
    click(find_element(:link_text, "Create New Account"))
    SdetRecursion.check_for_element(".//div[text()='Sign Up']", 4)
    # if IO.puts element?(:xpath, ".//div[text()='Sign Up']") do
    #   :timer.sleep(2000)
    #   IO.puts element?(:xpath, ".//div[text()='Sign Up']")
    # end

    click(find_element(:name, "firstname"))
    send_text("Test")
    click(find_element(:name, "lastname"))
    send_text("Testerson")
    click(find_element(:name, "reg_email__"))
    send_text("testermail@mailinator.com")
    click(find_element(:id, "month"))
    click(find_element(:xpath, ".//select[@id='month']/option[@value='2']"))
    click(find_element(:id, "day"))
    click(find_element(:xpath, ".//select[@id='day']/option[@value='2']"))
    click(find_element(:id, "year"))
    click(find_element(:xpath, ".//select[@id='year']/option[@value='1988']"))
  end
end