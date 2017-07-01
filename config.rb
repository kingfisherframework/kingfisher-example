require "warden"
require "services/authentication"
require "kingfisher/repo"
require "kingfisher/database_backends/sqlite3"
require "kingfisher/middleware"
require "kingfisher/middlewares/file_logger"

class Config
  attr_reader :backend, :repo, :request, :middlewares
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
    @backend = Kingfisher::DatabaseBackends::SqlLite3.new
    @repo = Kingfisher::Repo
    @middlewares = Kingfisher::MiddlewareStack.new

    middlewares.use Kingfisher::Middlewares::FileLogger, file: "log/development.log"
    middlewares.use Rack::Static, root: "web/public"
    middlewares.use Rack::Session::Cookie, secret: ENV.fetch("SECRET_KEY_BASE")
    middlewares.use Rack::MethodOverride
    middlewares.use Warden::Manager do |manager|
      manager.failure_app = ->(env) { [400, { "Content-Type" => "plain/text" }, ["Auth Failure"]] }
    end

    Warden::Strategies.add(:password_strategy, BcryptPasswordStrategy)
    Warden::Manager.serialize_into_session { |user| user[:id] }
    Warden::Manager.serialize_from_session { |id| env["repo"].find(User, id) }
  end
end
