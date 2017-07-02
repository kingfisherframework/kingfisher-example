$LOAD_PATH.unshift(".")

require "pry"
require "dotenv/load"
require "web/router"
require "config"
require "kingfisher/app"

router = Router.new
config = Config.new

run Kingfisher::App.new(router, config)
