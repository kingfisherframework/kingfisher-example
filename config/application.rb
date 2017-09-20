require "rack"

module Twitter
  class Application
    def self.start
      Rack::Server.new.start
    end
  end
end

$LOAD_PATH.unshift File.expand_path("../", __dir__)

require "warden"
require "services/authentication"
require "kingfisher/repo"
require "kingfisher/database_backends/postgresql"
require "kingfisher/database_backends/sqlite3"
require "kingfisher/middleware"
require "kingfisher/middlewares/file_logger"

class ApplicationConfig
  attr_reader :backend, :repo, :middlewares, :root
  def initialize
    @root = File.expand_path("..", __dir__)
    setup_database
    setup_middleware
  end

  def server
    ServerProxy.new
  end

  def setup_database
    @backend = Kingfisher::DatabaseBackends::PostgreSQL.new(database_url: database_url)
    @repo = Kingfisher::Repo
  end

  def setup_middleware
    @middlewares = Kingfisher::MiddlewareStack.new

    middlewares.use Rack::Static, root: "web/public"
    middlewares.use Rack::Session::Cookie, secret: ENV.fetch("SECRET_KEY_BASE")
    middlewares.use Rack::MethodOverride
    middlewares.use Warden::Manager do |manager|
      manager.failure_app = ->(env) { [400, { "Content-Type" => "plain/text" }, ["Auth Failure"]] }
    end
    setup_environment_middleware
  end

  class ServerProxy
    def start
      require_relative "./boot"
    end
  end
end
