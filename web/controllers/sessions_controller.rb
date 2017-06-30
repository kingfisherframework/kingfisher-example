require "kingfisher/controller"
require "services/sign_out"

class SessionsController < Kingfisher::Controller
  def delete
    SignOut.new(request).run
    redirect to: "/"
  end
end
