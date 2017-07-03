require "Kingfisher_helper"

RSpec.describe SignUp do
  it "creates an user" do
    user_params = { "email" => "me@example.com", "password" => "password" }
    request = double(env: { "repo" => repo })

    SignUp.new(user_params, request).run

    expect(repo.all(User).last).to include(email: "me@example.com")
  end
end
