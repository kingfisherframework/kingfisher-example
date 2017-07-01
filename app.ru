$LOAD_PATH.unshift(".")

require "warden"
require "pry"
require "services/authentication"
require "web"
require "dotenv/load"

instance_eval(File.read(File.expand_path("middleware.rb", __dir__)))

run Web.new
