require "kingfisher/view"
require "kingfisher/csrf"

class ApplicationView < Kingfisher::View
  def current_user
    request.env["warden"].user
  end

  def signed_in?
    !!current_user
  end

  def csrf
    @_csrf ||= Kingfisher::CSRF.new(request)
  end
end
