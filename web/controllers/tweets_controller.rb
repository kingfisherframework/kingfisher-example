require "model/recipe"
require "web/views/recipes_view"
require "kingfisher/controller"

class TweetsController < Kingfisher::Controller
  def create
    recipes = repo.all(Recipe)
    RecipesView.new(recipes: recipes)
  end
end
