defmodule ElixirSdetExerciseTest do
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

  setup do
    maximize_window(current_window_handle())
    navigate_to "https://facebook.com"
    unless element?(:link_text, "Create New Account") do
      navigate_to "https://facebook.com"
    end
    Helpers.click_create_new_account
    Loopers.check_for_element(".//div[text()='Sign Up']", 5)
  end

  @tag :name_test
  test "Invalid Name Message Appears With Bad Data In First Name Field" do
    good_email = Helpers.get_good_email
    Helpers.fill_first_name "    "
    Helpers.fill_last_name "Testerson"
    Helpers.fill_email_1 good_email
    Helpers.fill_email_2 good_email
    Helpers.fill_password "password123456"
    Helpers.select_month "2"
    Helpers.select_date "5"
    Helpers.select_year "1979"
    Helpers.select_male_gender
    Helpers.click_sign_up_submit
    Loopers.check_for_element(".//div[text()='What\’s your name?']", 6)
    try do
      assert element?(:xpath, ".//div[text()='What\’s your name?']")
    rescue
      _error ->
        Helpers.grab_screenshot "whitespace_lname_catch_shot_"
        Loopers.check_for_element(".//div[text()='What\’s your name?']", 6)
    end
    assert element?(:xpath, ".//div[text()='What\’s your name?']")
  end

  @tag :name_test
  test "Invalid name error for whitespace in last name field" do
    good_email = Helpers.get_good_email
    Helpers.fill_first_name "Test"
    Helpers.fill_last_name "      "
    Helpers.fill_email_1 good_email
    Helpers.fill_email_2 good_email
    Helpers.fill_password "password123456"
    Helpers.select_month "2"
    Helpers.select_date "27"
    Helpers.select_year "1966"
    Helpers.select_male_gender
    Helpers.click_sign_up_submit
    Loopers.check_for_element(".//div[text()='What\’s your name?']", 6)
    try do
      assert element?(:xpath, ".//div[text()='What\’s your name?']")
    rescue
      _error ->
        Helpers.grab_screenshot "whitespace_lname_catch_shot_"
        Loopers.check_for_element(".//div[text()='What\’s your name?']", 6)
    end
    assert element?(:xpath, ".//div[text()='What\’s your name?']")
  end
  
  @tag :name_test
  test "Names can't have too many periods message" do
    good_email = Helpers.get_good_email
    Helpers.fill_first_name "Test"
    Helpers.fill_last_name "element.png"
    Helpers.fill_email_1 good_email
    Helpers.fill_email_2 good_email
    Helpers.fill_password "password123456"
    Helpers.select_month "2"
    Helpers.select_date "5"
    Helpers.select_year "1979"
    Helpers.select_custom_gender "6"
    Helpers.click_sign_up_submit
    Loopers.check_for_element(".//*[@id='reg_error_inner']", 8)
    elem = find_element(:id, "reg_error_inner")
    try do
      assert(visible_in_element?(elem, ~r/Names on Facebook can't have too many periods. Learn more about our name policies./iu))
    rescue
      _error ->
        Helpers.grab_screenshot "too_many_periods_catch_shot_"
        Loopers.check_for_element(".//*[@id='reg_error_inner']", 8)
    end
    Loopers.check_for_element(".//*[@id='reg_error_inner']", 8)
    assert(visible_in_element?(elem, ~r/Names on Facebook can't have too many periods. Learn more about our name policies./iu))
  end

  @tag :name_test
  test "Names can't have too many punctuation marks message" do
    good_email = Helpers.get_good_email
    Helpers.fill_first_name "Test"
    Helpers.fill_last_name "element...png"
    Helpers.fill_email_1 good_email
    Helpers.fill_email_2 good_email
    Helpers.fill_password "password123456"
    Helpers.select_month "2"
    Helpers.select_date "5"
    Helpers.select_year "1979"
    Helpers.select_custom_gender "6"
    Helpers.click_sign_up_submit
    Loopers.check_for_element(".//*[@id='reg_error_inner']", 8)
    elem = find_element(:id, "reg_error_inner")
    try do
      assert(visible_in_element?(elem, ~r/Names on Facebook can't have too many punctuation marks. Learn more about our name policies./iu))
    rescue
      _error ->
        Helpers.grab_screenshot "too_many_punctuations_catch_shot_"
        Loopers.check_for_element(".//*[@id='reg_error_inner']", 8)
    end
    Loopers.check_for_element(".//*[@id='reg_error_inner']", 8)
    assert(visible_in_element?(elem, ~r/Names on Facebook can't have too many punctuation marks. Learn more about our name policies./iu))
  end

  @tag :name_test
  test "Name requirement error message" do
    good_email = Helpers.get_good_email
    Helpers.fill_first_name "asdf"
    Helpers.fill_last_name "asdf"
    Helpers.fill_email_1 good_email
    Helpers.fill_email_2 good_email
    Helpers.fill_password "password123456"
    Helpers.select_month "2"
    Helpers.select_date "5"
    Helpers.select_year "1979"
    Helpers.select_custom_gender "6"
    Helpers.click_sign_up_submit
    Loopers.check_for_element(".//*[@id='reg_error_inner']", 6)
    elem = find_element(:id, "reg_error_inner")
    try do
      assert(visible_in_element?(elem, ~r/We require everyone to use the name they use in everyday life, what their friends call them, on Facebook. Learn more about our name policies./iu))
    rescue
      _error ->
        Helpers.grab_screenshot "name_req_catch_shot_"
        Loopers.check_for_element(".//*[@id='reg_error_inner']", 6)
    end
    Loopers.check_for_element(".//*[@id='reg_error_inner']", 6)
    assert(visible_in_element?(elem, ~r/We require everyone to use the name they use in everyday life, what their friends call them, on Facebook. Learn more about our name policies./iu))
  end

  @tag :phone_test
  test "Invalid phone number error message" do
    Helpers.fill_first_name "Test"
    Helpers.fill_last_name "Mismatchmail"
    Helpers.fill_email_1 "801-555-55555"
    Helpers.fill_password "password123456"
    Helpers.select_month "12"
    Helpers.select_date "31"
    Helpers.select_year "2000"
    Helpers.select_custom_gender "6"
    Helpers.click_sign_up_submit
    Loopers.check_for_element(".//div[text()='Please enter a valid mobile number or email address.']", 6)
    try do
      assert element?(:xpath, ".//div[text()='Please enter a valid mobile number or email address.']")
    rescue
      _error ->
        Helpers.grab_screenshot "bad_phone_number_catch_shot_"
        IO.puts "Looping again"
        Loopers.check_for_element(".//div[text()='Please enter a valid mobile number or email address.']", 6)
    end
    assert element?(:xpath, ".//div[text()='Please enter a valid mobile number or email address.']")
  end

  @tag :email_test
  test "Email mismatch test" do
    good_email = Helpers.get_good_email
    bad_email = Helpers.get_bad_email
    Helpers.fill_first_name "Test"
    Helpers.fill_last_name "Mismatchmail"
    Helpers.fill_email_1 good_email
    Helpers.fill_email_2 bad_email
    Helpers.fill_password "password123456"
    Helpers.select_month "12"
    Helpers.select_date "31"
    Helpers.select_year "1981"
    Helpers.select_custom_gender "6"
    Helpers.click_sign_up_submit
    Loopers.check_for_element(".//div[text()='Your emails do not match. Please try again.']", 4)
    try do
      assert element?(:xpath, ".//div[text()='Your emails do not match. Please try again.']")
    rescue
      _error ->
        Helpers.grab_screenshot "email_mismatch_catch_shot_"
        IO.puts "Looping again"
        Loopers.check_for_element(".//div[text()='Your emails do not match. Please try again.']", 4)
    end
    assert element?(:xpath, ".//div[text()='Your emails do not match. Please try again.']")
  end

  @tag :email_test
  test "Invalid email message with bad data" do
    bad_email = Helpers.get_bad_email
    Helpers.fill_first_name "Test"
    Helpers.fill_last_name "Testerson"
    Helpers.fill_email_1 bad_email
    Helpers.fill_email_2 bad_email
    Helpers.fill_password "password123456"
    Helpers.select_month "2"
    Helpers.select_date "5"
    Helpers.select_year "1989"
    Helpers.select_female_gender
    Helpers.click_sign_up_submit
    Loopers.check_for_element(".//*[@id='reg_error_inner']", 6)
    try do
      assert(element?(:xpath,".//div[@id='reg_error_inner' and text()='You have entered an invalid email. Please check your email address and try again.']"))
    rescue
      _error ->
        Helpers.grab_screenshot "invalid_email_catch_shot_"
        Loopers.check_for_element(".//*[@id='reg_error_inner']", 6)
    end
    assert(element?(:xpath,".//div[@id='reg_error_inner' and text()='You have entered an invalid email. Please check your email address and try again.']"))
  end

  @tag :password_test
  test "Password not secure enough error message" do
    good_email = Helpers.get_good_email
    Helpers.fill_first_name "Test"
    Helpers.fill_last_name "Testerson"
    Helpers.fill_email_1 good_email
    Helpers.fill_email_2 good_email
    Helpers.fill_password "password"
    Helpers.select_month "2"
    Helpers.select_date "5"
    Helpers.select_year "1989"
    Helpers.select_female_gender
    Helpers.click_sign_up_submit
    Loopers.check_for_element(".//*[@id='reg_error_inner']", 10)
    try do
      assert(element?(:xpath,".//div[@id='reg_error_inner' and text()='Please choose a more secure password. It should be longer than 6 characters, unique to you, and difficult for others to guess.']"))
    rescue
      _error ->
        Helpers.grab_screenshot "insecure_pass_catch_shot_"
    end
    Loopers.check_for_element(".//*[@id='reg_error_inner']", 6)
    assert(element?(:xpath,".//div[@id='reg_error_inner' and text()='Please choose a more secure password. It should be longer than 6 characters, unique to you, and difficult for others to guess.']"))
  end
  
  @tag :password_test
  test "Password too short error message" do
    good_email = Helpers.get_good_email
    Helpers.fill_first_name "Test"
    Helpers.fill_last_name "Testerson"
    Helpers.fill_email_1 good_email
    Helpers.fill_email_2 good_email
    Helpers.fill_password "asdf"
    Helpers.select_month "2"
    Helpers.select_date "5"
    Helpers.select_year "1991"
    Helpers.select_female_gender
    Helpers.click_sign_up_submit
    Loopers.check_for_element(".//*[@id='reg_error_inner']", 10)
    try do
      assert(element?(:xpath,".//div[@id='reg_error_inner' and text()='Your password must be at least 6 characters long. Please try another.']"))
    rescue
      _error ->
        Helpers.grab_screenshot "pass_too_short_catch_shot_"
    end
    Loopers.check_for_element(".//*[@id='reg_error_inner']", 6)
    assert(element?(:xpath,".//div[@id='reg_error_inner' and text()='Your password must be at least 6 characters long. Please try another.']"))
  end

  @tag :birthday_test
  test "Setting invalid birthday day" do
    good_email = Helpers.get_good_email
    Helpers.fill_first_name "Test"
    Helpers.fill_last_name "Testerson"
    Helpers.fill_email_1 good_email
    Helpers.fill_email_2 good_email
    Helpers.fill_password "password123234"
    Helpers.select_month "12"
    Helpers.select_date "0"
    Helpers.select_year "1988"
    Helpers.click_sign_up_submit
    Helpers.click_sign_up_submit
    Helpers.click_sign_up_submit
    Helpers.click_sign_up_submit
    try do
      assert element?(:xpath, ".//*[text()='Please enter your age.']")
    rescue
      _error ->
        Helpers.grab_screenshot "invalid_day_catch_shot_"
    end
  end

  @tag :birthday_test
  test "Setting invalid birthday month" do
    good_email = Helpers.get_good_email
    Helpers.fill_first_name "Test"
    Helpers.fill_last_name "Testerson"
    Helpers.fill_email_1 good_email
    Helpers.fill_email_2 good_email
    Helpers.fill_password "password123234"
    Helpers.select_month "0"
    Helpers.select_date "31"
    Helpers.select_year "1966"
    Helpers.click_sign_up_submit
    Helpers.click_sign_up_submit
    Helpers.click_sign_up_submit
    Helpers.click_sign_up_submit
    try do
      assert element?(:xpath, ".//*[text()='Please enter your age.']")
    rescue
      _error ->
        Helpers.grab_screenshot "invalid_month_catch_shot_"
    end
  end

  @tag :birthday_test
  test "Setting age field to 400" do
    good_email = Helpers.get_good_email
    Helpers.fill_first_name "Test"
    Helpers.fill_last_name "Testerson"
    Helpers.fill_email_1 good_email
    Helpers.fill_email_2 good_email
    Helpers.fill_password "password123234"
    Helpers.select_month "12"
    Helpers.select_date "31"
    Helpers.select_year "0"
    Helpers.click_sign_up_submit
    Helpers.click_sign_up_submit
    Helpers.click_sign_up_submit
    Helpers.click_sign_up_submit
    try do
      Helpers.fill_out_age_input 400
    rescue
      _error ->
        Helpers.grab_screenshot "age_input_missing_catch_shot_"
    after
      Helpers.fill_out_age_input 400
    end
    Helpers.click_sign_up_submit
    try do
      assert element?(:xpath, ".//*[text()='Please enter your age.']")
    rescue
      error ->
        Helpers.grab_screenshot "age_input_error_catch_shot_"
        IO.puts "Taking screenshot of forced failure"
        raise error
    end
  end

  @tag :birthday_test
  test "Invalid Birthday from future message with bad data" do
    good_email = Helpers.get_good_email
    Helpers.fill_first_name "Test"
    Helpers.fill_last_name "Testerson"
    Helpers.fill_email_1 good_email
    Helpers.fill_email_2 good_email
    Helpers.fill_password "password123234"
    Helpers.select_month "12"
    Helpers.select_date "31"
    Helpers.select_year "2020"
    Helpers.select_female_gender
    Helpers.click_sign_up_submit
    Loopers.check_for_element(".//*[text()='It looks like you entered the wrong info. Please be sure to use your real birthday.']", 6)
    try do
      assert element?(:xpath, ".//*[text()='It looks like you entered the wrong info. Please be sure to use your real birthday.']")
    rescue
      _error ->
        Helpers.grab_screenshot "future_baby_catch_shot_"
        Loopers.check_for_element(".//*[text()='It looks like you entered the wrong info. Please be sure to use your real birthday.']", 6)
    end
    assert element?(:xpath, ".//*[text()='It looks like you entered the wrong info. Please be sure to use your real birthday.']")
  end
  
  @tag :gender_test
  test "Not selecting Gender error message" do
    good_email = Helpers.get_good_email
    Helpers.fill_first_name "Test"
    Helpers.fill_last_name "Testerson"
    Helpers.fill_email_1 good_email
    Helpers.fill_email_2 good_email
    Helpers.fill_password "password123234"
    Helpers.select_month "12"
    Helpers.select_date "31"
    Helpers.select_year "1967"
    Helpers.click_sign_up_submit
    Loopers.check_for_element(".//*[text()='Please choose a gender. You can change who can see this later.']", 6)
    try do
      assert element?(:xpath, ".//*[text()='Please choose a gender. You can change who can see this later.']")
    rescue
      _error ->
        Helpers.grab_screenshot "gender_failure_catch_shot_"
        Loopers.check_for_element(".//*[text()='Please choose a gender. You can change who can see this later.']", 6)
    end
    assert element?(:xpath, ".//*[text()='Please choose a gender. You can change who can see this later.']")
  end

  @tag :gender_test
  test "Not selecting pronoun error message" do
    good_email = Helpers.get_good_email
    Helpers.fill_first_name "Test"
    Helpers.fill_last_name "Testerson"
    Helpers.fill_email_1 good_email
    Helpers.fill_email_2 good_email
    Helpers.fill_password "password123234"
    Helpers.select_month "12"
    Helpers.select_date "31"
    Helpers.select_year "1967"
    Helpers.select_custom_gender "0"
    Helpers.click_sign_up_submit
    Loopers.check_for_element(".//*[text()='Please select your pronoun.']", 6)
    try do
      assert element?(:xpath, ".//*[text()='Please select your pronoun.']")
    rescue
      _error ->
        Helpers.grab_screenshot "pronoun_catch_shot_"
        Loopers.check_for_element(".//*[text()='Please select your pronoun.']", 6)
    end
    assert element?(:xpath, ".//*[text()='Please select your pronoun.']")
  end
end