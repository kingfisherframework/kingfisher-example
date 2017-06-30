require "web/controllers/home_controller"
require "web/controllers/tweets_controller"
require "kingfisher/route_set"
require "kingfisher/router"

class Router < Kingfisher::Router
  def initialize
    get("/", HomeController, :show)
    post("/tweet", TweetsController, :create)
  end
end
