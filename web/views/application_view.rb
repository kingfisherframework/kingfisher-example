require "kingfisher/view"
require "kingfisher/csrf"

class ApplicationView < Kingfisher::View
  def repo
    request.env["repo"]
  end

  def current_user
    request.env["warden"].user
  end

  def signed_in?
    !!request.env["warden"].user
  end

  def csrf
    @_csrf ||= Kingfisher::CSRF.new(request)
  end
end
