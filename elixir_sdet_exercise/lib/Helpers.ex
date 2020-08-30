defmodule Helpers do
  use Hound.Helpers

  def get_the_time do
    hour = to_string(Time.utc_now.hour)
    minute = to_string(Time.utc_now.minute)
    second = to_string(Time.utc_now.second)
    hour <> minute <> second
  end

  def grab_screenshot name do
    take_screenshot("test/screenshots/#{name}#{get_the_time()}.png")
  end

  def get_good_email do
    "testermail#{get_the_time()}@gmail.com"
  end

  def get_bad_email do
    "testerbadmail#{get_the_time()}@mailinator.com"
  end

end