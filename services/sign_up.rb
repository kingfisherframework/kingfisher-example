require "models/user"

class SignUp
  def initialize(repo, params)
    @repo = repo
    @params = params
  end

  def run
    repo.create(User, params)
  end

  private
  attr_reader :params, :repo
end
