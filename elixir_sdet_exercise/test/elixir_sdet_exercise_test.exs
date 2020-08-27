defmodule TimeGen do
  def get_the_time do
    hour = to_string(Time.utc_now.hour)
    minute = to_string(Time.utc_now.minute)
    second = to_string(Time.utc_now.second)
    hour <> minute <> second
  end
end

defmodule Helpers do
  use Hound.Helpers
  require TimeGen

  def fill_first_name fname do
    click(find_element(:name, "firstname"))
    send_text(fname)
  end

  def fill_last_name lname do
    click(find_element(:name, "lastname"))
    send_text(lname)
  end

  def fill_email_1 email1 do
    click(find_element(:name, "reg_email__"))
    send_text(email1)
  end

  def fill_email_2 email2 do
    unless element?(:name, "reg_email_confirmation__") do
      :timer.sleep(1500)
    end
    click(find_element(:name, "reg_email_confirmation__"))
    send_text(email2)
  end

  def fill_password pass do
    click(find_element(:id, "password_step_input"))
    send_text(pass)
  end

  def click_by type, matcher do
    if type == "id" do
      click(find_element(:id, "#{matcher}"))
    end
    if type == "xpath" do
      click(find_element(:xpath, "#{matcher}"))
    end
    if type == "name" do
      click(find_element(:name, "#{matcher}"))
    end
  end

  def select_month month_val do
    click_by("id", "month")
    unless element?(:xpath, ".//select[@id='month']/option[@value='#{month_val}']") do
      :timer.sleep(600)
    end
    click_by("xpath", ".//select[@id='month']/option[@value='#{month_val}']")
  end

  def select_date day_val do
    click_by("id", "day")
    unless element?(:xpath, ".//select[@id='day']/option[@value='#{day_val}']") do
      :timer.sleep(600)
    end
    click_by("xpath", ".//select[@id='day']/option[@value='#{day_val}']")
  end

  def select_year year_val do
    click_by("id", "year")
    unless element?(:xpath, ".//select[@id='day']/option[@value='#{year_val}']") do
      :timer.sleep(600)
    end
    click_by("xpath", ".//select[@id='year']/option[@value='#{year_val}']")
  end

  def select_male_gender do
    click(find_element(:xpath, ".//span/label[text()='Male']"))
  end
  
  def select_female_gender do
    click(find_element(:xpath, ".//span/label[text()='Female']"))
  end

  #as of right now, the pref_prounoun_values are as follows:
  #1 = She: "\Wish her a happy birthday!"\
  #2 = He: "\Wish him a happy birthday!"\
  #6 = They: "\Wish them a happy birthday!"\
  def select_custom_gender pref_pronoun_val do
    click(find_element(:xpath, ".//span/label[text()='Custom']"))
    click_by("name", "preferred_pronoun")
    click_by("xpath", ".//div[@id='custom_gender_container']/div/select/option[@value='#{pref_pronoun_val}']")
  end

  def click_sign_up_submit do
    click_by("name", "websubmit")
  end

  def grab_screenshot name do
    IO.puts "Taking screenshot!"
    take_screenshot("test/screenshots/#{name}#{TimeGen.get_the_time}.png")
  end

  def fill_out_age_input age do
    click_by("name", "birthday_age")
    send_text("#{age}")
  end


end

defmodule ElixirSdetExerciseTest do
  # Import helpers
  require Helpers
  use Hound.Helpers
  use ExUnit.Case
  require TimeGen
  

  # Start hound session and destroy when tests are run
  hound_session()
  setup do
    navigate_to "https://facebook.com"
    unless element?(:link_text, "Create New Account") do
      navigate_to "https://facebook.com"
    end
    click(find_element(:link_text, "Create New Account"))
    unless element?(:xpath, ".//div[text()='Sign Up']") do
      :timer.sleep(1300)
    end
  end

  # test "Invalid Name Message Appears With Bad Data In First Name Field" do
  #   good_email = "testermail#{TimeGen.get_the_time}@gmail.com"
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
  #   good_email = "testermail#{TimeGen.get_the_time}@gmail.com"
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

  test "Names can't have too many periods message" do
    good_email = "testermail#{TimeGen.get_the_time}@gmail.com"
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
    if element?(:id, "reg_error_inner") do
      IO.puts "Invalid name message missing. Checking again."
      :timer.sleep(2000)
      IO.puts element?(:id, "reg_error_inner")
    end
    try do
      error_code = find_element(:id, "reg_error_inner")
    rescue
      error ->
        IO.puts "Going to try and grab that element once more..."
        :timer.sleep(2000)
        raise error
    end
    error_code = find_element(:id, "reg_error_inner")
    #assert for message
    try do
      assert(visible_in_element?(error_code, ~r/Names on Facebook can't have too many periods. Learn more about our name policies./iu))
    rescue
      error ->
        Helpers.grab_screenshot "too_many_periods_catch_shot_"
        IO.puts "Trying to assert once more..."
        # assert(visible_in_element?(error_code, ~r/Names on Facebook can't have too many periods. Learn more about our name policies./iu))
        raise error
    end
    #sleeping to try and get this to pass one more time
    :timer.sleep(2000)
    assert(visible_in_element?(error_code, ~r/Names on Facebook can't have too many periods. Learn more about our name policies./iu))
  end

  # test "Invalid phone number error message" do
  #   #code
  # end

  # test "Email mismatch test" do
  #   good_email = "testermail#{TimeGen.get_the_time}@gmail.com"
  #   good_email_2 = "testermail2#{TimeGen.get_the_time}@gmail.com"
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
  #   good_email = "testermail#{TimeGen.get_the_time}@gmail.com"
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
  #   bad_email = "testermail#{TimeGen.get_the_time}@mailinator.com"
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
  #   good_email = "testermail#{TimeGen.get_the_time}@gmail.com"
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
  #   good_email = "testermail#{TimeGen.get_the_time}@gmail.com"
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
  #   #code (You need to set year to 0 and the screen comes up)
  #   good_email = "testermail#{TimeGen.get_the_time}@gmail.com"
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
  #     error ->
  #       Helpers.grab_screenshot "age_input_missing_catch_shot_"
  #       IO.puts "Taking screenshot of forced failure"
  #       Helpers.click_sign_up_submit
  #       Helpers.click_sign_up_submit
  #       Helpers.click_sign_up_submit
  #       raise error
  #   after
  #     Helpers.fill_out_age_input 400
  #   end
  #   # Now click the Sign Up Button
  #   :timer.sleep(4000)
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