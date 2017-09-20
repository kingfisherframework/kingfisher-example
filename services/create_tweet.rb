require "models/user"
require "models/tweet"

class CreateTweet
  def initialize(repo, params)
    @repo = repo
    @params = params
  end

  def run
    repo.create(Tweet, params)
  end

  private
  attr_reader :params, :repo
end
