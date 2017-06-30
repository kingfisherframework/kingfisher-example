require "model/recipe"
require "web/views/recipes_view"
require "kingfisher/controller"

class RecipesController < Kingfisher::Controller
  def index
    recipes = repo.all(Recipe)
    RecipesView.new(recipes)
  end
end
