require "web/views/home_view"
require "web/controllers/application_controller"

class HomeController < ApplicationController
  def show
    view HomeView
  end
end
