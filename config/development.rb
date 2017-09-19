require_relative "application"

class Config < ApplicationConfig
  def setup_environment_middleware
    middlewares.use Kingfisher::Middlewares::FileLogger, file: "log/development.log"
  end

  def database_url
    "postgres://localhost/kingfisher_development"
  end
end
