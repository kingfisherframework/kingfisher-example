class Authentication
  def initialize(user, plaintext_password)
    @user = user
    @plaintext_password = plaintext_password
  end

  def run
    if user && BCrypt::Password.new(user[:password_digest]) == plaintext_password
      user
    else
      false
    end
  end

  private
  attr_reader :user, :plaintext_password
end
