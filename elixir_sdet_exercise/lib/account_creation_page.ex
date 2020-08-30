defmodule AccountCreationPage do
  
  require Actions
  use Hound.Helpers
  
  #UI Elements
  @first_name "firstname"
  @last_name "lastname"
  @email1 "reg_email__"
  @email2 "reg_email_confirmation__"
  @password "password_step_input"
  @month_selector "month"
  @day_selector "day"
  @year_selector "year"
  @male_gender_selector ".//span/label[text()='Male']"
  @female_gender_selector ".//span/label[text()='Female']"
  @custom_gender_selector ".//span/label[text()='Custom']"
  @preferred_pronoun_selector "preferred_pronoun"
  @sign_up_submit_button "websubmit"
  @age_input "birthday_age"
  @create_new_account_btn "Create New Account"


  def fill_first_name fname do
    Actions.click_by("name", "#{@first_name}")
    send_text(fname)
  end

  def fill_last_name lname do
    Actions.click_by("name", "#{@last_name}")
    send_text(lname)
  end

  def fill_email_1 email1 do
    Actions.click_by("name", "#{@email1}")
    send_text(email1)
  end

  def fill_email_2 email2 do
    Actions.click_by("name", "#{@email2}")
    send_text(email2)
  end

  def fill_password pass do
    Actions.click_by("id", "#{@password}")
    send_text(pass)
  end

  def select_month month_val do
    Actions.click_by("id", "#{@month_selector}")
    Actions.click_by("xpath", ".//select[@id='month']/option[@value='#{month_val}']")
  end

  def select_date day_val do
    Actions.click_by("id", "#{@day_selector}")
    Actions.click_by("xpath", ".//select[@id='day']/option[@value='#{day_val}']")
  end

  def select_year year_val do
    Actions.click_by("id", "#{@year_selector}")
    Actions.click_by("xpath", ".//select[@id='year']/option[@value='#{year_val}']")
  end

  def select_male_gender do
    Actions.click_by("xpath", "#{@male_gender_selector}")
  end
  
  def select_female_gender do
    Actions.click_by("xpath", "#{@female_gender_selector}")
  end

  #as of right now, the pref_prounoun_values are as follows:
  #0 = No gender is selected
  #1 = She: "\Wish her a happy birthday!"\
  #2 = He: "\Wish him a happy birthday!"\
  #6 = They: "\Wish them a happy birthday!"\
  def select_custom_gender pref_pronoun_val do
    Actions.click_by("xpath", "#{@custom_gender_selector}")
    unless pref_pronoun_val == "0" do
      Actions.click_by("name", "#{@preferred_pronoun_selector}")
      Actions.click_by("xpath", ".//div[@id='custom_gender_container']/div/select/option[@value='#{pref_pronoun_val}']")
    end
  end

  def click_sign_up_submit do
    Actions.click_by("name", "#{@sign_up_submit_button}")
  end

  def fill_out_age_input age do
    Actions.click_by("name", "#{@age_input}")
    send_text("#{age}")
  end

  def click_create_new_account do
    Actions.click_by("link_text", "#{@create_new_account_btn}")
  end
end