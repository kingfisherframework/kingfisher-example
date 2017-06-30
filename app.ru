$LOAD_PATH.unshift(".")

require "web/router"
require "config"
require "warden"
require "pry"

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

use Rack::Static, root: "web/public"
use Rack::Session::Cookie, secret: "82d58d3dfb91238b495a311eb8539edf5064784f1d58994679db8363ec241c745bef0b446bfe44d66cbf91a2f4e497d8f6b1ef1656e3f405b0d263a9617ac75e"

use Warden::Manager do |manager|
  manager.default_strategies :password, :basic
  manager.failure_app = ->(env) { [400, { "Content-Type" => "plain/text" }, ["Auth Failure"]] }
end

run Web.new
