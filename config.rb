require "warden"
require "services/authentication"
require "kingfisher/repo"
require "kingfisher/sqlite3_backend"
require "kingfisher/middleware"

class Config
  attr_reader :backend, :repo, :request, :middleware
  class BcryptPasswordStrategy < ::Warden::Strategies::Base
    def valid?
      params["id"] && params["password"]
    end

    def authenticate!
      Authentication.new(user, params["password"]).run
    end

    private

    def user
      env["repo"].find_by(User, id: params["id"])
    end
  end

  def initialize
    @backend = Kingfisher::SqlLite3Backend.new("data/repo.sql")
    @repo = Kingfisher::Repo
    @request = Rack::Request
    @middleware = Kingfisher::MiddlewareStack.new

    middleware.use Rack::Static, root: "web/public"
    middleware.use Rack::Session::Cookie, secret: "82d58d3dfb91238b495a311eb8539edf5064784f1d58994679db8363ec241c745bef0b446bfe44d66cbf91a2f4e497d8f6b1ef1656e3f405b0d263a9617ac75e"
    middleware.use Rack::MethodOverride
    middleware.use Warden::Manager do |manager|
      manager.failure_app = ->(env) { [400, { "Content-Type" => "plain/text" }, ["Auth Failure"]] }
    end

    Warden::Strategies.add(:password_strategy, BcryptPasswordStrategy)
    Warden::Manager.serialize_into_session { |user| user[:id] }
    Warden::Manager.serialize_from_session { |id| env["repo"].find(User, id) }
  end
end
