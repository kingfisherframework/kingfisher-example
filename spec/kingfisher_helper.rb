$LOAD_PATH.unshift File.expand_path("../", __dir__)

require "web"
require "capybara/dsl"
require "capybara/rspec"
require "dotenv/load"

Capybara.app = Rack::Builder.new do
  map("/") do
    instance_eval(File.read(File.expand_path("../middleware.rb", __dir__)))
    run Web.new
  end
end.to_app

Capybara.save_path = "tmp/capybara"
