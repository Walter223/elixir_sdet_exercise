defmodule Helpers do
  use Hound.Helpers
  # require TimeGen

  def get_the_time do
    hour = to_string(Time.utc_now.hour)
    minute = to_string(Time.utc_now.minute)
    second = to_string(Time.utc_now.second)
    hour <> minute <> second
  end

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
    take_screenshot("test/screenshots/#{name}#{get_the_time()}.png")
  end

  def fill_out_age_input age do
    click_by("name", "birthday_age")
    send_text("#{age}")
  end

  def get_good_email do
    "testermail#{get_the_time()}@gmail.com"
  end


end