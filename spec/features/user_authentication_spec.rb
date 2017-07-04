require "kingfisher_helper"

RSpec.feature "User authentication" do
  def create_user(attributes)
    repo.create(User, attributes)
  end

  def sign_in(email, password)
    visit "/"
    click_link "Sign in"
    fill_in "Email", with: email
    fill_in "Password", with: password
    click_button "Sign in"
  end

  scenario "new user signs up" do
    visit "/"

    click_link "Sign up"
    fill_in "Email", with: "me@example.com"
    fill_in "Password", with: "password"
    click_button "Sign up"

    expect(page).to have_content("Welcome me@example.com")
  end

  scenario "existing user signs in" do
    password_digest = BCrypt::Password.create("password")
    user = create_user(email: "me@example.com", password_digest: password_digest)

    sign_in("me@example.com", "password")

    expect(page).to have_content(user[:email])
  end

  scenario "existing user signs out" do
    password_digest = BCrypt::Password.create("password")
    user = create_user(email: "me@example.com", password_digest: password_digest)
    sign_in("me@example.com", "password")

    visit "/"
    click_button "Sign out"

    expect(page).not_to have_content(user[:email])
  end
end
