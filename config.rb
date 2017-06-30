require "kingfisher/repo"
require "kingfisher/sqlite3_backend"

class Config
  attr_reader :backend, :repo, :request, :middleware

  def initialize
    @backend = Kingfisher::SqlLite3Backend.new("data/repo.sql")
    @repo = Kingfisher::Repo
    @request = Rack::Request
    @middleware = [
      [Rack::Static, root: "web/public"]
    ]
  end
end
