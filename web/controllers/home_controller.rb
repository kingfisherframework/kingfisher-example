require "model/recipe"
require "web/views/recipes_view"
require "kingfisher/controller"

class HomeController < Kingfisher::Controller
  # params
  # cookies
  # session
  # request

  def show
    HomeView.new
  end
end
