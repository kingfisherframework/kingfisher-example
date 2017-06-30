$LOAD_PATH.unshift(".")

require "warden"
require "pry"
require "services/authentication"
require "web"

load "middleware"

run Web.new
