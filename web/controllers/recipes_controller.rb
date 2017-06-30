require "model/recipe"
Response = Struct.new(:status_code, :headers, :multipart_body)

class RecipesController
  def initialize(request)
    @request = request
  end

  def repo
    @request.env["repo"]
  end

  def index
    recipes = repo.all(Recipe)
    Response.new(200, {}, [recipes.inspect])
  end
end
