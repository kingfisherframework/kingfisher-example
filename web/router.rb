require "web/controllers/recipes_controller"
require "kingfisher/route_set"

class Router
  NoRouteError = Class.new(StandardError)

  def initialize
    @route_set = Kingfisher::RouteSet.new
    @route_set.get("/", RecipesController, :index)
    @route_set.get("/foo", RecipesController, :index)
  end

  def route(request)
    @route_set.match(request)
  end
end
