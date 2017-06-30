require "model/recipe"
require "web/views/recipes_view"
require "kingfisher/controller"

class HomeController < Kingfisher::Controller
  def show
    recipes = repo.all(Recipe)
    RecipesView.new(recipes: recipes)
  end
end
