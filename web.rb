require "config"
require "web/router"
require "warden"

class Web
  def initialize
    @config = Config.new
    @router = Router.new
    Warden::Manager.serialize_into_session { |user| user[:id] }
    Warden::Manager.serialize_from_session { |id| env["repo"].find(User, id) }
  end

  def call(env)
    request = config.request.new(env)
    request.env["repo"] = repo
    resp = router.route(request).call(request)
    $stdout.puts resp.inspect
    resp
  end

  private
  attr_reader :router, :config

  def repo
    @repo ||= config.repo.new(config.backend)
  end
end
