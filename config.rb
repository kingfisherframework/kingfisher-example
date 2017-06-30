require_relative "kingfisher/repo"
require_relative "kingfisher/sqlite3_backend"

class Config
  attr_reader :backend, :repo, :request, :middleware

  def initialize
    @backend = Kingfisher::SqlLite3Backend.new("data/repo.sql")
    @repo = Kingfisher::Repo
    @request = Rack::Request
  end
end
