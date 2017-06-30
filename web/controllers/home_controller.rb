require "web/views/home_view"
require "kingfisher/controller"

class HomeController < Kingfisher::Controller
  def show
    HomeView.new(request)
  end
end
