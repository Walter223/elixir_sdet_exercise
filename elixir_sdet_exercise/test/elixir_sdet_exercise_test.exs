defmodule ElixirSdetExerciseTest do
  # Import helpers
  require Helpers
  require Loopers
  use Hound.Helpers
  use ExUnit.Case
  

  # Start hound session and destroy when tests are run
  hound_session()
  setup do
    navigate_to "https://facebook.com"
    unless element?(:link_text, "Create New Account") do
      navigate_to "https://facebook.com"
    end
    click(find_element(:link_text, "Create New Account"))
    Loopers.check_for_element(".//div[text()='Sign Up']", 5)
  end

  # test "Invalid Name Message Appears With Bad Data In First Name Field" do
  #   good_email = "testermail#{Helpers.get_the_time}@gmail.com"
  #   #fill in first name
  #   Helpers.fill_first_name "    "
  #   #fill in last name
  #   Helpers.fill_last_name "Testerson"
  #   #fill in email
  #   Helpers.fill_email_1 good_email
  #   #fill in email again
  #   Helpers.fill_email_2 good_email
  #   #fill in password
  #   Helpers.fill_password "password123456"
  #   #fill in month
  #   Helpers.select_month "2"
  #   # #fill in day
  #   Helpers.select_date "5"
  #   # #fill in year
  #   Helpers.select_year "1979"
  #   Helpers.select_male_gender
  #   # # Now click the Sign Up Button
  #   Helpers.click_sign_up_submit    
  #   #assert that the error message shows up
  #   assert element?(:xpath, ".//div[text()='What\’s your name?']")
  # end

  # test "Invalid Name Message Appears With Bad Data In Last Name Field" do
  #   good_email = "testermail#{Helpers.get_the_time}@gmail.com"
  #   #fill in first name
  #   Helpers.fill_first_name "Test"
  #   #fill in last name
  #   Helpers.fill_last_name "      "
  #   #fill in email
  #   Helpers.fill_email_1 good_email
  #   #fill in email again
  #   Helpers.fill_email_2 good_email
  #   #fill in password
  #   Helpers.fill_password "password123456"
  #   #fill in month
  #   Helpers.select_month "2"
  #   # #fill in day
  #   Helpers.select_date "27"
  #   # #fill in year
  #   Helpers.select_year "1966"
  #   Helpers.select_male_gender
  #   # # Now click the Sign Up Button
  #   Helpers.click_sign_up_submit
  #   # click(find_element(:name,"websubmit"))
  #   IO.puts "Looking for What's your name message"
  #   #assert that the error message shows up
  #   assert element?(:xpath, ".//div[text()='What\’s your name?']")
  # end

  # #this one is being difficult...
  test "Names can't have too many periods message" do
    good_email = "testermail#{Helpers.get_the_time}@gmail.com"
    #fill in first name
    Helpers.fill_first_name "Test"
    #fill in last name
    Helpers.fill_last_name "element.png"
    #fill in email
    Helpers.fill_email_1 good_email
    #fill in email again
    Helpers.fill_email_2 good_email
    #fill in password
    Helpers.fill_password "password123456"
    #fill in month
    Helpers.select_month "2"
    # #fill in day
    Helpers.select_date "5"
    # #fill in year
    Helpers.select_year "1979"
    Helpers.select_custom_gender "6"
    # # Now click the Sign Up Button
    Helpers.click_sign_up_submit
    #check for error message
    Loopers.check_for_element(".//*[@id='reg_error_inner']", 4)
    # if element?(:id, "reg_error_inner") do
    #   IO.puts "Invalid name message missing. Checking again."
    #   :timer.sleep(2000)
    #   IO.puts element?(:id, "reg_error_inner")
    # end
    # try do
    #   error_code = find_element(:id, "reg_error_inner")
    # rescue
    #   _error ->
    #     IO.puts "Going to try and grab that element once more..."
    #     :timer.sleep(2000)
    # end
    error_code = find_element(:id, "reg_error_inner")
    IO.puts error_code
    #assert for message
    try do
      assert(visible_in_element?(error_code, ~r/Names on Facebook can't have too many periods. Learn more about our name policies./iu))
    rescue
      _error ->
        Helpers.grab_screenshot "too_many_periods_catch_shot_"
        IO.puts "Trying to assert once more..."
        # assert(visible_in_element?(error_code, ~r/Names on Facebook can't have too many periods. Learn more about our name policies./iu))
    end
    #sleeping to try and get this to pass one more time
    :timer.sleep(2000)
    assert(visible_in_element?(error_code, ~r/Names on Facebook can't have too many periods. Learn more about our name policies./iu))
  end

  # test "Invalid phone number error message" do
  #   #code
  # end

  # test "Email mismatch test" do
  #   good_email = "testermail#{Helpers.get_the_time}@gmail.com"
  #   good_email_2 = "testermail2#{Helpers.get_the_time}@gmail.com"
  #   #fill in first name
  #   Helpers.fill_first_name "Test"
  #   #fill in last name
  #   Helpers.fill_last_name "element.png"
  #   #fill in email
  #   Helpers.fill_email_1 good_email
  #   #fill in email again
  #   Helpers.fill_email_2 good_email_2
  #   #fill in password
  #   Helpers.fill_password "password123456"
  #   #fill in month
  #   Helpers.select_month "12"
  #   # #fill in day
  #   Helpers.select_date "31"
  #   # #fill in year
  #   Helpers.select_year "2020"
  #   Helpers.select_custom_gender "6"
  #   # # Now click the Sign Up Button
  #   Helpers.click_sign_up_submit
  #   #check for error message
  #   :timer.sleep(2000)
  #   #Need assertion
  #   assert element?(:xpath, ".//div[text()='Your emails do not match. Please try again.']")
  # end

  # # test "Setting invalid birthday" do
  # #   #code
  # # end

  # test "Password not secure enough error message" do
  #   good_email = "testermail#{Helpers.get_the_time}@gmail.com"
  #   #fill in first name
  #   Helpers.fill_first_name "Test"
  #   #fill in last name
  #   Helpers.fill_last_name "Testerson"
  #   #fill in email
  #   Helpers.fill_email_1 good_email
  #   #fill in email again
  #   Helpers.fill_email_2 good_email
  #   #fill in password
  #   Helpers.fill_password "password"
  #   #fill in month
  #   Helpers.select_month "2"
  #   # #fill in day
  #   Helpers.select_date "5"
  #   # #fill in year
  #   Helpers.select_year "1989"
  #   Helpers.select_female_gender
  #   # # Now click the Sign Up Button
  #   Helpers.click_sign_up_submit
  #   #check for error message
  #   if element?(:id, "reg_error_inner") do
  #     IO.puts "Invalid password message missing. Checking again."
  #     Helpers.grab_screenshot "pass_not_secure_enough_"
  #     :timer.sleep(1000)
  #   end
  #   #assert for message
  #   assert(element?(:xpath,".//div[@id='reg_error_inner' and text()='Please choose a more secure password. It should be longer than 6 characters, unique to you, and difficult for others to guess.']"))
  # end
 
  
  # test "Invalid email message with bad data" do
  #   bad_email = "testermail#{Helpers.get_the_time}@mailinator.com"
  #   #fill in first name
  #   Helpers.fill_first_name "Test"
  #   #fill in last name
  #   Helpers.fill_last_name "Testerson"
  #   #fill in email
  #   Helpers.fill_email_1 bad_email
  #   #fill in email again
  #   Helpers.fill_email_2 bad_email
  #   #fill in password
  #   Helpers.fill_password "password123456"
  #   #fill in month
  #   Helpers.select_month "2"
  #   # #fill in day
  #   Helpers.select_date "5"
  #   # #fill in year
  #   Helpers.select_year "1989"
  #   Helpers.select_female_gender
  #   # # Now click the Sign Up Button
  #   Helpers.click_sign_up_submit
  #   #check for error message
  #   if element?(:id, "reg_error_inner") do
  #     IO.puts "Invalid Email message missing. Checking again."
  #     Helpers.grab_screenshot "bad_email_"
  #     :timer.sleep(1000)
  #   end
  #   #assert for message
  #   assert(element?(:xpath,".//div[@id='reg_error_inner' and text()='You have entered an invalid email. Please check your email address and try again.']"))
  # end

  # test "Invalid Birthday message with bad data" do
  #   good_email = "testermail#{Helpers.get_the_time}@gmail.com"
  #   #fill in first name
  #   Helpers.fill_first_name "Test"
  #   #fill in last name
  #   Helpers.fill_last_name "Testerson"
  #   #fill in email
  #   Helpers.fill_email_1 good_email
  #   #fill in email again
  #   Helpers.fill_email_2 good_email
  #   #fill in password
  #   Helpers.fill_password "password123234"
  #   #fill in month
  #   Helpers.select_month "12"
  #   # #fill in day
  #   Helpers.select_date "31"
  #   # #fill in year
  #   Helpers.select_year "2020"
  #   Helpers.select_female_gender
  #   # # Now click the Sign Up Button
  #   Helpers.click_sign_up_submit
    
  #   if element?(:xpath, ".//*[text()='It looks like you entered the wrong info. Please be sure to use your real birthday.']") do
  #     Helpers.grab_screenshot "bad_birthday_missing_"
  #     IO.puts "Invalid birthday message missing. Checking again."
  #     :timer.sleep(1000)
  #   end
  #   #assert error message
  #   assert element?(:xpath, ".//*[text()='It looks like you entered the wrong info. Please be sure to use your real birthday.']")
  # end
  
  # test "Not selecting Gender error message" do
  #   good_email = "testermail#{Helpers.get_the_time}@gmail.com"
  #   #fill in first name
  #   Helpers.fill_first_name "Test"
  #   #fill in last name
  #   Helpers.fill_last_name "Testerson"
  #   #fill in email
  #   Helpers.fill_email_1 good_email
  #   #fill in email again
  #   Helpers.fill_email_2 good_email
  #   #fill in password
  #   Helpers.fill_password "password123234"
  #   #fill in month
  #   Helpers.select_month "12"
  #   # #fill in day
  #   Helpers.select_date "31"
  #   # #fill in year
  #   Helpers.select_year "2020"
  #   # Now click the Sign Up Button
  #   Helpers.click_sign_up_submit
  #   try do
  #     assert element?(:xpath, ".//*[text()='Please choose a gender. You can change who can see this later.']")
  #   rescue
  #     error ->
  #       Helpers.grab_screenshot "gender_failure_catch_shot_"
  #       IO.puts "Taking screenshot of forced failure"
  #       raise error
  #   end
  # end
  
  # test "Test the Your Age field with 400" do
  #   good_email = Helpers.get_good_email
  #   #fill in first name
  #   Helpers.fill_first_name "Test"
  #   #fill in last name
  #   Helpers.fill_last_name "Testerson"
  #   #fill in email
  #   Helpers.fill_email_1 good_email
  #   #fill in email again
  #   Helpers.fill_email_2 good_email
  #   #fill in password
  #   Helpers.fill_password "password123234"
  #   #fill in month
  #   Helpers.select_month "12"
  #   # #fill in day
  #   Helpers.select_date "31"
  #   # #fill in year
  #   Helpers.select_year "0"
  #   # Now click the Sign Up Button
  #   Helpers.click_sign_up_submit
  #   # Fill out age input
  #   try do
  #     Helpers.fill_out_age_input 400
  #   rescue
  #     _error ->
  #       Helpers.grab_screenshot "age_input_missing_catch_shot_"
  #       IO.puts "Taking screenshot of forced failure"
  #       Helpers.click_sign_up_submit
  #       Helpers.click_sign_up_submit
  #       Helpers.click_sign_up_submit
  #   after
  #     Helpers.fill_out_age_input 400
  #   end
  #   # Now click the Sign Up Button
  #   Helpers.click_sign_up_submit
  #   try do
  #     assert element?(:xpath, ".//*[text()='Please enter your age.']")
  #   rescue
  #     error ->
  #       Helpers.grab_screenshot "age_input_error_catch_shot_"
  #       IO.puts "Taking screenshot of forced failure"
  #       raise error
  #   end
  # end

end