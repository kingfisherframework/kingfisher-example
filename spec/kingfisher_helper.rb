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

class TestDatabaseCleaner
  def clean_all
    Sequel::Model.db[:user].delete
  end
end

RSpec.configure do |config|
  config.before(:suite) do
    TestDatabaseCleaner.new.clean_all
  end

  config.after(:each) do
    TestDatabaseCleaner.new.clean_all
  end
end
