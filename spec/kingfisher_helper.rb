$LOAD_PATH.unshift File.expand_path("../", __dir__)

require "capybara/dsl"
require "capybara/rspec"

require "dotenv/load"
require "web/router"
require "config"
require "kingfisher/app"

router = Router.new
config = Config.new

Capybara.app = Kingfisher::App.new(router, config)

Capybara.save_path = "tmp/capybara"
