require "pry"
require "config/application"

class Config < ApplicationConfig
  def setup_environment_middleware
    middlewares.use Kingfisher::Middlewares::FileLogger, file: "log/test.log"
  end
end
