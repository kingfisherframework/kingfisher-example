require "kingfisher/controller"

class ForbiddenController < Kingfisher::Controller
  def show
    [403, {"Content-Type" => "text/plain"}, ["Forbidden"]]
  end
end
