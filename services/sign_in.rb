class SignIn
  def initialize(user, request)
    @user = user
    @warden = request.env["warden"]
  end

  def run
    warden.set_user(user)
  end

  private
  attr_reader :user, :warden
end
