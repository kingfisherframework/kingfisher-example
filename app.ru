$LOAD_PATH.unshift(".")

require "web/router"
require "config"

class Web
  def initialize
    @config = Config.new
    @router = Router.new
  end

  def call(env)
    request = config.request.new(env)
    request.env["repo"] = repo
    router.route(request).call(request)
  end

  private
  attr_reader :router, :config

  def repo
    @repo ||= config.repo.new(config.backend)
  end
end

use Rack::Static, root: "web/public"
run Web.new
