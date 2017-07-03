$LOAD_PATH.unshift File.expand_path("../", __dir__)

require "capybara/dsl"
require "capybara/rspec"

require "dotenv"
Dotenv.load(".env.test")

require "web/router"
require "config"
require "kingfisher/app"

router = Router.new
config = Config.new

Capybara.app = Kingfisher::App.new(router, config)

Capybara.save_path = "tmp/capybara"

require "database_cleaner"

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner[:sequel].clean_with(:deletion)
  end

  config.around(:each) do |example|
    DatabaseCleaner[:sequel].cleaning do
      example.run
    end
  end
end
