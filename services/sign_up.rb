require "bcrypt"
require "models/user"

class SignUp
  def initialize(params, request)
    @params = params
    @repo = request.env["repo"]
  end

  def run
    repo.create(User, user_params)
  end

  private
  attr_reader :params, :repo

  def user_params
    {
      email: params["email"],
      password_digest: password_digest
    }
  end

  def password_digest
    BCrypt::Password.create(params["password"])
  end
end
