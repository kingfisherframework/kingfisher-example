$LOAD_PATH.unshift(".")

require "pry"
require "dotenv/load"
require "web/router"
require "kingfisher/app"

router = Router.new

run Kingfisher::App.new(router)
