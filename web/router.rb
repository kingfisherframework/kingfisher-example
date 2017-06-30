require "web/controllers/home_controller"
require "web/controllers/tweets_controller"
require "web/controllers/users_controller"
require "web/controllers/sessions_controller"
require "kingfisher/route_set"
require "kingfisher/router"

class Router < Kingfisher::Router
  def initialize
    get "/", HomeController, :show

    get "/sign_up", UsersController, :new
    post "/sign_up", UsersController, :create

    post "/tweet", TweetsController, :create

    get "/sign_in", SessionsController, :new
    post "/sign_in", SessionsController, :create
    delete "/sign_out", SessionsController, :delete
  end
end
