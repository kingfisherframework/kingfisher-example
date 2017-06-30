require "kingfisher/view"

class HomeView < Kingfisher::View
  def initialize(request)
    @template = "home/show"
    @request = request
  end

  def current_user
    request.env["warden"].user
  end

  private
  attr_reader :request
end
