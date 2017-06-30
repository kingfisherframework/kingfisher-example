require "kingfisher_helper"

RSpec.feature "Home" do
  scenario "can access home page" do
    visit "/"

    expect(page).to have_text("Welcome to Twitter")
  end
end
