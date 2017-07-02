RSpec.describe SignUp do
  it "creates an user" do
    user_params = { "email" => "matt@example.com", "password" => "password" }
    request = double(env: { "repo" => repo })

    SignUp.new(user_params, request).run

    expect(repo.all(User).last).to include(email: "matt@example.com")
  end

  def repo
    Kingfisher::Repo.new(Config.new.backend)
  end
end
