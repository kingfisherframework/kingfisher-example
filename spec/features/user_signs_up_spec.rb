require "kingfisher_helper"

RSpec.feature "User signs up" do
  scenario "successfully" do
    visit "/"
    click_link "Sign up"
    fill_in "Email", with: "me@example.com"
    fill_in "Password", with: "password"
    click_button "Sign up"
    expect(page).to have_content("Welcome me@example.com")
  end
end
