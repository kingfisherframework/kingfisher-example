class SignIn
  def initialize(warden, user)
    @user = user
    @warden = warden
  end

  def run
    warden.set_user(user)
  end

  private
  attr_reader :user, :warden
end
