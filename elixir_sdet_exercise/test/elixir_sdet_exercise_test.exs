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

  test "Invalid First Name Message Appears With Bad Data" do
    navigate_to "https://facebook.com"
    click(find_element(:link_text, "Create New Account"))
    if IO.puts element?(:xpath, ".//div[text()='Sign Up']") do
      :timer.sleep(2000)
      IO.puts element?(:xpath, ".//div[text()='Sign Up']")
    end
    #fill in first name
    click(find_element(:name, "firstname"))
    send_text("    ")
    #fill in last name
    click(find_element(:name, "lastname"))
    send_text("Testerson")
    #fill in email
    click(find_element(:name, "reg_email__"))
    good_email = "testermail#{to_string(Time.utc_now)}@gmail.com"
    send_text(good_email)
    :timer.sleep(1000)
    #fill in email again
    click(find_element(:name, "reg_email_confirmation__"))
    send_text(good_email)
    #fill in password
    click(find_element(:id, "password_step_input"))
    send_text("password123")
    #fill in month
    click(find_element(:id, "month"))
    click(find_element(:xpath, ".//select[@id='month']/option[@value='2']"))
    #fill in day
    click(find_element(:id, "day"))
    click(find_element(:xpath, ".//select[@id='day']/option[@value='2']"))
    #fill in year
    click(find_element(:id, "year"))
    click(find_element(:xpath, ".//select[@id='year']/option[@value='1977']"))
    click(find_element(:xpath, ".//span/label[text()='Male']"))
    # Now click the Sign Up Button
    click(find_element(:name,"websubmit"))
    IO.puts "Looking for What's your name message"
    IO.puts element?(:xpath, './/div[text()="What\'s your name?"]')
    
  end

  test "Invalid Last Name Message With Bad Data" do
    navigate_to "https://facebook.com"
    click(find_element(:link_text, "Create New Account"))
    if IO.puts element?(:xpath, ".//div[text()='Sign Up']") do
      :timer.sleep(2000)
      IO.puts element?(:xpath, ".//div[text()='Sign Up']")
    end
    good_email = "testermail#{to_string(Time.utc_now)}@gmail.com"
    #fill in first name
    click(find_element(:name, "firstname"))
    send_text("Test")
    #fill in last name
    click(find_element(:name, "lastname"))
    send_text("      ")
    #fill in email
    click(find_element(:name, "reg_email__"))
    send_text(good_email)
    :timer.sleep(1000)
    #fill in email again
    click(find_element(:name, "reg_email_confirmation__"))
    send_text(good_email)
    #fill in password
    click(find_element(:id, "password_step_input"))
    send_text("password123")
    #fill in month
    click(find_element(:id, "month"))
    click(find_element(:xpath, ".//select[@id='month']/option[@value='2']"))
    #fill in day
    click(find_element(:id, "day"))
    click(find_element(:xpath, ".//select[@id='day']/option[@value='2']"))
    #fill in year
    click(find_element(:id, "year"))
    click(find_element(:xpath, ".//select[@id='year']/option[@value='1977']"))
    click(find_element(:xpath, ".//span/label[text()='Male']"))
    # Now click the Sign Up Button
    click(find_element(:name,"websubmit"))
    IO.puts element?(:xpath, './/div[text()="What\'s your name?"]')
  end

  test "Names can't have too many periods message" do
    navigate_to "https://facebook.com"
    click(find_element(:link_text, "Create New Account"))
    if IO.puts element?(:xpath, ".//div[text()='Sign Up']") do
      :timer.sleep(2000)
      IO.puts element?(:xpath, ".//div[text()='Sign Up']")
    end
    good_email = "testermail#{to_string(Time.utc_now)}@gmail.com"
    #fill in first name
    click(find_element(:name, "firstname"))
    send_text("Test")
    #fill in last name
    click(find_element(:name, "lastname"))
    send_text("element.png")
    #fill in email
    click(find_element(:name, "reg_email__"))
    send_text(good_email)
    :timer.sleep(1000)
    #fill in email again
    click(find_element(:name, "reg_email_confirmation__"))
    send_text(good_email)
    #fill in password
    click(find_element(:id, "password_step_input"))
    send_text("password123")
    #fill in month
    click(find_element(:id, "month"))
    click(find_element(:xpath, ".//select[@id='month']/option[@value='2']"))
    #fill in day
    click(find_element(:id, "day"))
    click(find_element(:xpath, ".//select[@id='day']/option[@value='2']"))
    #fill in year
    click(find_element(:id, "year"))
    click(find_element(:xpath, ".//select[@id='year']/option[@value='1977']"))
    click(find_element(:xpath, ".//span/label[text()='Male']"))
    # Now click the Sign Up Button
    click(find_element(:name,"websubmit"))
    
    #check for error message
    if IO.puts element?(:id, "reg_error_inner") do
      IO.puts "Invalid name message missing. Checking again."
      :timer.sleep(2000)
      IO.puts element?(:id, "reg_error_inner")
    end
    error_code = find_element(:id, "reg_error_inner")
    assert(error_code == "Names on Facebook can't have too many periods. ")
  end

  test "Password not secure enough error message" do
    navigate_to "https://facebook.com"
    click(find_element(:link_text, "Create New Account"))
    if IO.puts element?(:xpath, ".//div[text()='Sign Up']") do
      :timer.sleep(2000)
      IO.puts element?(:xpath, ".//div[text()='Sign Up']")
    end
    good_email = "testermail#{to_string(Time.utc_now)}@gmail.com"
    #fill in first name
    click(find_element(:name, "firstname"))
    send_text("Test")
    #fill in last name
    click(find_element(:name, "lastname"))
    send_text("element.png")
    #fill in email
    click(find_element(:name, "reg_email__"))
    send_text(good_email)
    :timer.sleep(1000)
    #fill in email again
    click(find_element(:name, "reg_email_confirmation__"))
    send_text(good_email)
    #fill in password
    click(find_element(:id, "password_step_input"))
    send_text("password123")
    #fill in month
    click(find_element(:id, "month"))
    click(find_element(:xpath, ".//select[@id='month']/option[@value='2']"))
    #fill in day
    click(find_element(:id, "day"))
    click(find_element(:xpath, ".//select[@id='day']/option[@value='2']"))
    #fill in year
    click(find_element(:id, "year"))
    click(find_element(:xpath, ".//select[@id='year']/option[@value='1977']"))
    click(find_element(:xpath, ".//span/label[text()='Male']"))
    # Now click the Sign Up Button
    click(find_element(:name,"websubmit"))
    
    #check for error message
    if IO.puts element?(:id, "reg_error_inner") do
      IO.puts "Invalid password message missing. Checking again."
      :timer.sleep(2000)
      IO.puts element?(:id, "reg_error_inner")
    end
    error_code = find_element(:id, "reg_error_inner")
    assert(error_code == "Please choose a more secure password. It should be longer than 6 characters, unique to you, and difficult for others to guess.")
    
    
  
  
    # test "Invalid email message with bad data" do
  #   navigate_to "https://facebook.com"
  #   click(find_element(:link_text, "Create New Account"))
  #   if IO.puts element?(:xpath, ".//div[text()='Sign Up']") do
  #     :timer.sleep(2000)
  #     IO.puts element?(:xpath, ".//div[text()='Sign Up']")
  #   end
  #   #fill in first name
  #   click(find_element(:name, "firstname"))
  #   send_text("Test")
  #   #fill in last name
  #   click(find_element(:name, "lastname"))
  #   send_text("Testerson")
  #   #fill in email
  #   click(find_element(:name, "reg_email__"))
  #   send_text("testermail@mailinator.com")
  #   :timer.sleep(1000)
  #   #fill in email again
  #   click(find_element(:name, "reg_email_confirmation__"))
  #   send_text("testermail@mailinator.com")
  #   #fill in password
  #   click(find_element(:id, "password_step_input"))
  #   send_text("password123")
  #   #fill in month
  #   click(find_element(:id, "month"))
  #   click(find_element(:xpath, ".//select[@id='month']/option[@value='2']"))
  #   #fill in day
  #   click(find_element(:id, "day"))
  #   click(find_element(:xpath, ".//select[@id='day']/option[@value='2']"))
  #   #fill in year
  #   click(find_element(:id, "year"))
  #   click(find_element(:xpath, ".//select[@id='year']/option[@value='1977']"))
  #   click(find_element(:xpath, ".//span/label[text()='Male']"))
  #   # Now click the Sign Up Button
  #   click(find_element(:name,"websubmit"))
  #   IO.puts element?(:xpath, './/div[text()="What\'s your name?"]')
  #   if IO.puts element?(:id, "reg_error_inner") do
  #     IO.puts "Invalid Email message missing. Checking again."
  #     :timer.sleep(2000)
  #     IO.puts element?(:id, "reg_error_inner")
  #   end
  #   error_code = find_element(:id, "reg_error_inner")
  #   assert(error_code == "You have entered an invalid email. Please check your email address and try again.")
  # end

  # test "Invalid Birthday message with bad data" do
  #   #code
  #   error_code = find_element(:id, "js_1d")
  #   assert(error_code == "It looks like you entered the wrong info. Please be sure to use your real birthday.")
  # end
end