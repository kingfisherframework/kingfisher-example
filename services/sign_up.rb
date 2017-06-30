require "models/user"

class SignUp
  def initialize(params, request)
    @params = params
    @repo = request.env["repo"]
  end

  def run
    repo.create(User, params)
  end

  private
  attr_reader :params, :repo
end
