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
  def fill_first_name fname do
    click(find_element(:name, "firstname"))
    send_text("#{fname}")
  end

  def fill_last_name lname do
    click(find_element(:name, "lastname"))
    send_text("#{lname}")
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
      :timer.sleep(1300)
    end
    click_by("xpath", ".//select[@id='month']/option[@value='#{month_val}']")
  end

  def select_date day_val do
    click_by("id", "day")
    unless element?(:xpath, ".//select[@id='day']/option[@value='#{day_val}']") do
      :timer.sleep(1300)
    end
    click_by("xpath", ".//select[@id='day']/option[@value='#{day_val}']")
  end

  def select_year year_val do
    click_by("id", "year")
    unless element?(:xpath, ".//select[@id='day']/option[@value='#{year_val}']") do
      :timer.sleep(1300)
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
    pref_pronoun = ""
    click(find_element(:xpath, ".//span/label[text()='Custom']"))
    click_by("name", "preferred_pronoun")
    if pref_pronoun_val == 1 do
      pref_pronoun = "She: \"Wish her a happy birthday!\""
    end
    if pref_pronoun_val == 2 do
      pref_pronoun = "He: \"Wish him a happy birthday!\""
    end
    if pref_pronoun == 6 do
      pref_pronoun = "They: \"Wish them a happy birthday!\""
    end
    click_by("xpath", ".//div[@id='custom_gender_container'/div/select/option[@text()='#{pref_pronoun}']")
  end

  def click_sign_up_submit do
    click_by("name", "websubmit")
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
    click(find_element(:link_text, "Create New Account"))
    if IO.puts element?(:xpath, ".//div[text()='Sign Up']") do
      :timer.sleep(1300)
      IO.puts element?(:xpath, ".//div[text()='Sign Up']")
    end
  end

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

  # test "Invalid Name Message Appears With Bad Data In First Name Field" do
  #   #fill in first name
  #   click(find_element(:name, "firstname"))
  #   send_text("    ")
  #   #fill in last name
  #   click(find_element(:name, "lastname"))
  #   send_text("Testerson")
  #   #fill in email
  #   click(find_element(:name, "reg_email__"))
  #   good_email = "testermail#{TimeGen.get_the_time}@gmail.com"
  #   send_text(good_email)
  #   :timer.sleep(1000)
  #   #fill in email again
  #   click(find_element(:name, "reg_email_confirmation__"))
  #   send_text(good_email)
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
  #   :timer.sleep(1000)
  #   #assert that the error message shows up
  #   assert element?(:xpath, ".//div[text()='What\’s your name?']")

  # end

  # test "Invalid Name Message Appears With Bad Data In Last Name Field" do
  #   good_email = "testermail#{TimeGen.get_the_time}@gmail.com"
  #   #fill in first name
  #   click(find_element(:name, "firstname"))
  #   send_text("Test")
  #   #fill in last name
  #   click(find_element(:name, "lastname"))
  #   send_text("      ")
  #   #fill in email
  #   click(find_element(:name, "reg_email__"))
  #   send_text(good_email)
  #   :timer.sleep(1000)
  #   #fill in email again
  #   click(find_element(:name, "reg_email_confirmation__"))
  #   send_text(good_email)
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
  #   IO.puts "Looking for What's your name message"
  #   :timer.sleep(1000)
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
    # click(find_element(:id, "month"))
    # click(find_element(:xpath, ".//select[@id='month']/option[@value='2']"))
    # #fill in day
    Helpers.select_date "5"
    # click(find_element(:id, "day"))
    # click(find_element(:xpath, ".//select[@id='day']/option[@value='2']"))
    # #fill in year
    Helpers.select_year "1979"
    # click(find_element(:id, "year"))
    # click(find_element(:xpath, ".//select[@id='year']/option[@value='1977']"))
    Helpers.select_male
    # click(find_element(:xpath, ".//span/label[text()='Male']"))
    # # Now click the Sign Up Button
    Helpers.click_sign_up_submit
    # click(find_element(:name,"websubmit"))
    
    # #check for error message
    # if element?(:id, "reg_error_inner") do
    #   IO.puts "Invalid name message missing. Checking again."
    #   :timer.sleep(2000)
    #   IO.puts element?(:id, "reg_error_inner")
    # end
    # error_code = find_element(:id, "reg_error_inner")
    # visible_in_element?(error_code, ~r/Names on Facebook can't have too many periods. Learn more about our name policies./iu)
    :timer.sleep(5400)
  end

  # test "Invalid phone number error message" do
  #   #code
  # end


  # test "Password not secure enough error message" do
  #   navigate_to "https://facebook.com"
  #   click(find_element(:link_text, "Create New Account"))
  #   if IO.puts element?(:xpath, ".//div[text()='Sign Up']") do
  #     :timer.sleep(2000)
  #     IO.puts element?(:xpath, ".//div[text()='Sign Up']")
  #   end
  #   good_email = "testermail#{TimeGen.get_the_time}@gmail.com"
  #   #fill in first name
  #   click(find_element(:name, "firstname"))
  #   send_text("Test")
  #   #fill in last name
  #   click(find_element(:name, "lastname"))
  #   send_text("element.png")
  #   #fill in email
  #   click(find_element(:name, "reg_email__"))
  #   send_text(good_email)
  #   :timer.sleep(1000)
  #   #fill in email again
  #   click(find_element(:name, "reg_email_confirmation__"))
  #   send_text(good_email)
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
    
  #   #check for error message
  #   if IO.puts element?(:id, "reg_error_inner") do
  #     IO.puts "Invalid password message missing. Checking again."
  #     :timer.sleep(2000)
  #     IO.puts element?(:id, "reg_error_inner")
  #   end
  #   error_code = find_element(:id, "reg_error_inner")
  #   assert(error_code == "Please choose a more secure password. It should be longer than 6 characters, unique to you, and difficult for others to guess.")
  # end
    
  
  
    # test "Invalid email message with bad data" do
  #   navigate_to "https://facebook.com"
  #   click(find_element(:link_text, "Create New Account"))
  #   if IO.puts element?(:xpath, ".//div[text()='Sign Up']") do
  #     :timer.sleep(2000)
  #     IO.puts element?(:xpath, ".//div[text()='Sign Up']")
  #   end
  #   bad_email = "testermail#{TimeGen.get_the_time}@mailinator.com"
  #   #fill in first name
  #   click(find_element(:name, "firstname"))
  #   send_text("Test")
  #   #fill in last name
  #   click(find_element(:name, "lastname"))
  #   send_text("Testerson")
  #   #fill in email
  #   click(find_element(:name, "reg_email__"))
  #   send_text(bad_email)
  #   :timer.sleep(1000)
  #   #fill in email again
  #   click(find_element(:name, "reg_email_confirmation__"))
  #   send_text(bad_email)
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