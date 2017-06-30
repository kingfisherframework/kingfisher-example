$LOAD_PATH.unshift(".")
require "web/router"
require "data/repo"
require "data/sqlite3_backend"

class Web
  def initialize
    @router = Router.new
    @repo = Repo.new(SqlLite3Backend.new("data/repo.sql"))
  end

  def call(env)
    request = Rack::Request.new(env)
    request.env["repo"] = @repo
    @router.route(request).call(request)
  end
end

use Rack::Static, root: "web/public"
run Web.new
