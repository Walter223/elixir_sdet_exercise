defmodule Actions do
  use Hound.Helpers

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
    if type == "link_text" do
      click(find_element(:link_text, "#{matcher}"))
    end
  end

end