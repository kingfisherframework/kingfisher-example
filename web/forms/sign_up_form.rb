require "bcrypt"

class SignUpForm
  def initialize(request)
    @request = request
  end

  def params
    {
      email: request.params["email"],
      password_digest: password_digest
    }
  end

  private
  attr_reader :request

  def password_digest
    BCrypt::Password.create(request.params["password"])
  end
end
