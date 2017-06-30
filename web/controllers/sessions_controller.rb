require "kingfisher/controller"
require "services/sign_out"
require "services/sign_in"
require "services/authentication"
require "web/views/sign_in_view"

class SessionsController < Kingfisher::Controller
  def new
    SignInView.new
  end

  def create
    user = authenticated_user
    if user
      SignIn.new(user, request).run
      redirect to: "/"
    else
      redirect to: "/"
    end
  end

  def delete
    SignOut.new(request).run
    redirect to: "/"
  end

  private

  def authenticated_user
    user = repo.find_by(User, email: params["email"])
    Authentication.new(user, params["password"]).run
  end
end
