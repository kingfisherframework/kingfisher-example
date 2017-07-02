require "kingfisher/view"

class ApplicationView < Kingfisher::View
  def current_user
    request.env["warden"].user
  end

  def signed_in?
    !!current_user
  end
end
