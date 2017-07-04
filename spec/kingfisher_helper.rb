$LOAD_PATH.unshift File.expand_path("../", __dir__)

require "capybara/dsl"
require "capybara/rspec"

require "dotenv"
Dotenv.load(".env.test")

require "web/router"
require "kingfisher/app"
require "config/test"

Capybara.app = Kingfisher::App.new(Router.new, Config.new)
Capybara.save_path = "tmp/capybara"

Warden.test_mode!

Dir["spec/support/**/*.rb"].each { |f| require f }
RSpec.configure do |config|
  config.include RepoHelper

  config.after :each do
    Warden.test_reset!
  end
end
