require "web/controllers/home_controller"
require "web/controllers/tweets_controller"
require "web/controllers/users_controller"
require "kingfisher/route_set"
require "kingfisher/router"

class Router < Kingfisher::Router
  def initialize
    get("/", HomeController, :show)
    get("/sign_up", UsersController, :new)
    post("/sign_up", UsersController, :create)
    post("/tweet", TweetsController, :create)
  end
end
