require "kingfisher/view"

class RecipesView < Kingfisher::View
  def initialize(recipes)
    @recipes = recipes
  end
end
