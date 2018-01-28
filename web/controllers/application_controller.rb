require "kingfisher/controller"

class ApplicationController < Kingfisher::Controller
  private

  def repo
    request.env["dependencies"].service(:repo)
  end
end
