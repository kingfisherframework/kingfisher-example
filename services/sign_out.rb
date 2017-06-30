class SignOut
  def initialize(request)
    @warden = request.env["warden"]
  end

  def run
    warden.logout
  end

  private
  attr_reader :warden
end
