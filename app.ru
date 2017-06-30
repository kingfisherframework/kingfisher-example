$LOAD_PATH.unshift(".")

require "web/router"
require "kingfisher/repo"
require "kingfisher/sqlite3_backend"

class Web
  def initialize
    @router = Router.new
    @repo = Kingfisher::Repo.new(Kingfisher::SqlLite3Backend.new("data/repo.sql"))
  end

  def call(env)
    request = Rack::Request.new(env)
    request.env["repo"] = repo
    router.route(request).call(request)
  end

  private
  attr_reader :router, :repo
end

use Rack::Static, root: "web/public"
run Web.new
