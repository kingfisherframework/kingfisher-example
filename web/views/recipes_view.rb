require "kingfisher/view"
require "slim"

class RecipesView < Kingfisher::View
  def initialize(view_variables)
    @view_variables = view_variables
  end

  def render
    Slim::Template.new("web/templates/recipes/index.slim").render(self, view_variables)
  end

  private

    attr_reader :view_variables
end
