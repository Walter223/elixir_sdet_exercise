defmodule LoginPage do
  
  require Actions
  use Hound.Helpers
  
  #Elements 
  @login_email  "email"
  @login_pass  "pass"
  @login_login_btn  "Log In"

  def fill_out_login_email email do
    Actions.click_by("id", "#{@login_email}")
    send_text(email)
  end

  def fill_out_login_pass pass do
    Actions.click_by("id", "#{@login_pass}")
    send_text(pass)
  end

  def click_login_button do
    Actions.click_by("link_text", "#{@login_login_btn}")
  end

end