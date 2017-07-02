$LOAD_PATH.unshift File.expand_path("../", __dir__)

require "capybara/dsl"
require "capybara/rspec"

require "dotenv"
Dotenv.load(".env.test")

require "web/router"
require "kingfisher/app"

router = Router.new

Capybara.app = Kingfisher::App.new(router)

Capybara.save_path = "tmp/capybara"

Dir["spec/support/**/*.rb"].each { |f| require f }
RSpec.configure do |config|
  config.include RepoHelper
end
